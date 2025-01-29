import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/network/http_response_model.dart';
import 'package:tracking_apps/configs/network/user_interface.dart';
import 'package:tracking_apps/domain/entity/permit_list_response.dart';
import 'package:tracking_apps/domain/entity/permit_model.dart';
import 'package:tracking_apps/domain/entity/user_model.dart';

class UserService extends UserInterface {
  final String _baseUrl = dotenv.env['BASE_URL'] ?? "";

  @override
  Future<HttpResponseModel> login(
      {required String email, required String password}) async {
    try {
      var url = Uri.parse('$_baseUrl/dev/users/login');

      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)["data"]["token"],
        status: jsonDecode(response.body)["status"],
        message: jsonDecode(response.body)["message"],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }

  @override
  Future<HttpResponseModel> create(
      {required String username,
      required String email,
      required String password}) async {
    try {
      var url = Uri.parse('$_baseUrl/dev/users');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
        },
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)["data"],
        message: jsonDecode(response.body)["message"],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }

  @override
  Future<HttpResponseModel> delete({required String id}) async {
    try {
      var url = Uri.parse('$_baseUrl/users/$id');
      var response = await http.delete(url);

      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)["data"],
        message: jsonDecode(response.body)["message"],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }

  @override
  Future<HttpResponseModel> getById({required String id}) async {
    try {
      var url = Uri.parse('$_baseUrl/users/$id');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Accept': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
        },
      );

      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)["data"],
        message: jsonDecode(response.body)["message"],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }

  @override
  Future<HttpResponseModel> validate({required String token}) async {
    try {
      var url = Uri.parse('$_baseUrl/dev/users/current');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Accept': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
          'Authorization': 'Bearer $token',
        },
      );

      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)["data"],
        message: jsonDecode(response.body)["message"],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }

  @override
  Future<HttpResponseModel> update({required UserModel userModel}) async {
    try {
      var url = Uri.parse('$_baseUrl/users/${userModel.id}');
      var response = await http.put(
        url,
        body: jsonEncode({
          'username': userModel.userName,
        }),
      );

      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)["data"],
        message: jsonDecode(response.body)["message"],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }

  Future<void> saveAuthTokenToSP(String authToken) async {
    await SharedPreferencesService.instance
        .setData(PreferenceKey.authToken, authToken);
  }

  Future<String?> getAuthTokenFromSP() async {
    return SharedPreferencesService.instance.getData(PreferenceKey.authToken);
  }

  Future<void> deleteAuthTokenFromSP() async {
    await SharedPreferencesService.instance.removeData(PreferenceKey.authToken);
  }

  @override
  Future<HttpResponseModel<PermitListResponse>> getListPermit({
    required String authToken,
  }) async {
    try {
      var url = Uri.parse('$_baseUrl/dev/permit-letters/');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Accept': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final permitListResponse =
            PermitListResponse.fromMap(jsonResponse as Map<String, dynamic>);
        return HttpResponseModel(
          statusCode: response.statusCode,
          data: permitListResponse,
          status: jsonResponse['status'],
          message: jsonResponse['message'],
        );
      } else {
        return HttpResponseModel(
          statusCode: response.statusCode,
          message:
              jsonDecode(response.body)['message'] ?? 'Error fetching permits',
          status: 'error',
        );
      }
    } catch (e) {
      return HttpResponseModel(message: 'Error Fetching Data $e');
    }
  }

  @override
  Future<HttpResponseModel<PermitModel>> getDetailPermit(
      {required String authToken, required String id}) async {
    try {
      var url = Uri.parse('$_baseUrl/dev/permit-letters/$id');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Accept': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        print('API Response: ${response.body}');
        final jsonResponse = jsonDecode(response.body);
        final permitModel = PermitModel.fromMap(jsonResponse['data']);
        return HttpResponseModel(
          statusCode: response.statusCode,
          data: permitModel,
          status: jsonResponse['status'],
          message: jsonResponse['message'],
        );
      } else {
        return HttpResponseModel(
          statusCode: response.statusCode,
          message:
              jsonDecode(response.body)['message'] ?? 'Error fetching permits',
          status: 'error',
        );
      }
    } catch (e) {
      return HttpResponseModel(message: 'Error Fetching Data $e');
    }
  }

  @override
  Future<HttpResponseModel<PermitModel>> createPermit({
    required String description,
    required String noPermit,
    required String categoryPermit,
    required String companyName,
    required String date,
    required String authToken,
    String? noPermitMabes,
    required String documentUrl,
    String? processStatus,
  }) async {
    try {
      var url = Uri.parse('$_baseUrl/dev/permit-letters/upload');
      var request = http.MultipartRequest('POST', url);

      request.fields['uraian'] = description;
      request.fields['no_surat'] = noPermit;
      request.fields['kategori_permit_letter'] = categoryPermit;
      request.fields['nama_pt'] = companyName;
      request.fields['tanggal'] = date;
      request.fields['status_tahapan'] = processStatus ?? 'Draft Created';
      if (noPermitMabes != null) {
        request.fields['produk_no_surat_mabes'] = noPermitMabes;
      }
      request.headers['Authorization'] = 'Bearer $authToken';
      final mimeType = lookupMimeType(documentUrl);

      if (documentUrl != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'dokumen',
          documentUrl,
          contentType: mimeType != null ? MediaType.parse(mimeType) : null,
        ));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print('Response Body: ${response.body}');

        final data = responseBody['data'];
        if (data != null && data is Map<String, dynamic>) {
          try {
            final permitData = PermitModel.fromMap(data);
            return HttpResponseModel<PermitModel>(
              statusCode: response.statusCode,
              data: permitData,
              status: responseBody['status'] as String?,
              message: responseBody['message'] as String?,
            );
          } catch (e) {
            print('Error during PermitModel parsing: $e');
            return HttpResponseModel<PermitModel>(
              statusCode: response.statusCode,
              data: null,
              status: responseBody['status'] as String?,
              message: 'Error parsing data: $e',
            );
          }
        } else {
          return HttpResponseModel<PermitModel>(
            statusCode: response.statusCode,
            data: null,
            status: responseBody['status'] as String?,
            message: 'Invalid or missing data field in response',
          );
        }
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print('Response Body: ${response.body}');
        return HttpResponseModel<PermitModel>(
          statusCode: response.statusCode,
          data: null,
          status: responseBody['status'] as String?,
          message: responseBody['message'] as String? ?? 'Unknown error',
        );
      }
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }

  @override
  Future<HttpResponseModel> updatePermit(
      {required String id,
      required String authToken,
      String? processStatus}) async {
    try {
      var url = Uri.parse('$_baseUrl/dev/permit-letters/edit/$id');
      var response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode({'status_tahapan': processStatus}),
      );
      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)["data"],
        status: jsonDecode(response.body)["status"],
        message: jsonDecode(response.body)["message"],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }

  @override
  Future<HttpResponseModel> deletePermit({
    required String id,
    required String authToken,
  }) async {
    try {
      var url = Uri.parse('$_baseUrl/dev/permit-letters/delete/$id');
      var response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)["data"],
        status: jsonDecode(response.body)["status"],
        message: jsonDecode(response.body)["message"],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }
}
