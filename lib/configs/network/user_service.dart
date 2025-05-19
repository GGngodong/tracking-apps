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
      var url = Uri.parse('$_baseUrl/users/login');

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
  Future<HttpResponseModel> resetPassword({
    required String email,
  }) async {
    try {
      var url = Uri.parse('$_baseUrl/users/forgot-password');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
        },
        body: jsonEncode({
          'email': email,
        }),
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
  Future<HttpResponseModel> create({
    required String username,
    required String email,
    required String password,
    required String division,
  }) async {
    try {
      var url = Uri.parse('$_baseUrl/users');
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
          'division': division,
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
  Future<HttpResponseModel> delete({required String authToken}) async {
    try {
      var url = Uri.parse('$_baseUrl/users/logout');
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
      var url = Uri.parse('$_baseUrl/users/current');
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
      var url = Uri.parse('$_baseUrl/permit-letters/');
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
      var url = Uri.parse('$_baseUrl/permit-letters/$id');
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
    required String documentUrl,
    required String categoryAdministration,
    String? noPermitMabes,
    String? processStatus,
    String? uploadStatus,
  }) async {
    try {
      var url = Uri.parse('$_baseUrl/permit-letters/upload');
      var request = http.MultipartRequest('POST', url);

      request.fields['uraian'] = description;
      request.fields['no_surat'] = noPermit;
      request.fields['kategori_permit_letter'] = categoryPermit;
      request.fields['nama_pt'] = companyName;
      request.fields['tanggal'] = date;
      request.fields['status_tahapan'] = processStatus ?? 'Draft Created';
      request.fields['sub_kategori_permit_letter'] = categoryAdministration;
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
  Future<HttpResponseModel<PermitModel>> updatePermit({
    required String id,
    required String authToken,
    String? noProdukMabes,
    String? processStatus,
    String? uploadStatus,
    String? note,
    String? documentUrl,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl/permit-letters/edit/$id');
      final request = http.MultipartRequest('POST', url);
      request.fields['_method'] = 'PUT';
      if (processStatus != null) {
        request.fields['status_tahapan'] = processStatus;
      }
      if (uploadStatus != null) {
        request.fields['upload_status'] = uploadStatus;
      }
      if (noProdukMabes != null) {
        request.fields['produk_no_surat_mabes'] = noProdukMabes;
      }
      if (note != null) {
        request.fields['note'] = note;
      }

      request.headers['Authorization'] = 'Bearer $authToken';

      if (documentUrl != null && documentUrl.isNotEmpty) {
        final mimeType = lookupMimeType(documentUrl);
        request.files.add(await http.MultipartFile.fromPath(
          'dokumen',
          documentUrl,
          contentType: mimeType != null ? MediaType.parse(mimeType) : null,
        ));
      }

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      final body = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200 || response.statusCode == 201) {
        final dataMap = body['data'] as Map<String, dynamic>?;
        final permit = dataMap != null ? PermitModel.fromMap(dataMap) : null;

        return HttpResponseModel<PermitModel>(
          statusCode: response.statusCode,
          data: permit,
          status: body['status'] as String?,
          message: body['message'] as String?,
        );
      } else {
        return HttpResponseModel<PermitModel>(
          statusCode: response.statusCode,
          data: null,
          status: body['status'] as String?,
          message: body['message'] as String? ?? 'Unknown error',
        );
      }
    } catch (e) {
      return HttpResponseModel<PermitModel>(
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
      var url = Uri.parse('$_baseUrl/permit-letters/delete/$id');
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

  @override
  Future<HttpResponseModel> searchPermit({
    String? searchParam,
    String? searchQuery,
    String? categoryPermitSearchQuery,
    String? categoryPermitSearchParam,
    String? subCategoryPermitSearchQuery,
    String? subCategoryPermitSearchParam,
    required String authToken,
  }) async {
    try {
      final Map<String, String> params = {};

      if (searchParam != null &&
          searchParam.isNotEmpty &&
          searchQuery != null &&
          searchQuery.isNotEmpty) {
        params[searchParam] = searchQuery;
      }

      if (categoryPermitSearchParam != null &&
          categoryPermitSearchParam.isNotEmpty &&
          categoryPermitSearchQuery != null &&
          categoryPermitSearchQuery.isNotEmpty) {
        params[categoryPermitSearchParam] = categoryPermitSearchQuery;
      }

      if (subCategoryPermitSearchParam != null &&
          subCategoryPermitSearchParam.isNotEmpty &&
          subCategoryPermitSearchQuery != null &&
          subCategoryPermitSearchQuery.isNotEmpty) {
        params[subCategoryPermitSearchParam] = subCategoryPermitSearchQuery;
      }

      final uri = Uri.parse('$_baseUrl/permit-letters/search')
          .replace(queryParameters: params);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        final permitListResponse = PermitListResponse.fromMap(jsonResponse);

        return HttpResponseModel(
          statusCode: response.statusCode,
          data: permitListResponse,
          status: jsonResponse['status'] as String?,
          message: jsonResponse['message'] as String?,
        );
      }

      else if (response.statusCode == 404) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        return HttpResponseModel(
          statusCode: response.statusCode,
          status: 'error',
          message: body['message'] as String,
        );
      }

      else {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        return HttpResponseModel(
          statusCode: response.statusCode,
          status: 'error',
          message: body['message'] as String? ?? 'Error fetching permits',
        );
      }
    } catch (e) {
      return HttpResponseModel(message: 'Error fetching data: $e');
    }
  }

  @override
  Future<HttpResponseModel<PermitListResponse>> getReleasePermit(
      {required String authToken}) async {
    try {
      var url = Uri.parse('$_baseUrl/permit-letters/released');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'Authorization': 'Bearer $authToken',
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final releaseListResponse =
            PermitListResponse.fromMap(jsonResponse as Map<String, dynamic>);
        return HttpResponseModel(
          statusCode: response.statusCode,
          data: releaseListResponse,
          status: jsonResponse['status'],
          message: jsonResponse['message'],
        );
      } else {
        return HttpResponseModel(
          statusCode: response.statusCode,
          message:
              jsonDecode(response.body)['message'] ?? 'Error Fetching Permits',
          status: 'error',
        );
      }
    } catch (e) {
      return HttpResponseModel(message: 'Error Fetching Data $e');
    }
  }

  @override
  Future<HttpResponseModel<PermitListResponse>> getApprovedPermit({
    required String authToken,
  }) async {
    try {
      var url = Uri.parse('$_baseUrl/permit-letters/approved');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'Authorization': 'Bearer $authToken',
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final approvedListResponse =
            PermitListResponse.fromMap(jsonResponse as Map<String, dynamic>);
        return HttpResponseModel(
          statusCode: response.statusCode,
          data: approvedListResponse,
          status: jsonResponse['status'],
          message: jsonResponse['message'],
        );
      } else {
        return HttpResponseModel(
          statusCode: response.statusCode,
          message:
              jsonDecode(response.body)['message'] ?? 'Error Fetching Permits',
          status: 'error',
        );
      }
    } catch (e) {
      return HttpResponseModel(message: 'Error Fetching Data $e');
    }
  }

  @override
  Future<HttpResponseModel<PermitListResponse>> getRejectedPermit({
    required String authToken,
  }) async {
    try {
      var url = Uri.parse('$_baseUrl/permit-letters/rejected');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'Authorization': 'Bearer $authToken',
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final rejectedListResponse =
            PermitListResponse.fromMap(jsonResponse as Map<String, dynamic>);
        return HttpResponseModel(
          statusCode: response.statusCode,
          data: rejectedListResponse,
          status: jsonResponse['status'],
          message: jsonResponse['message'],
        );
      } else {
        return HttpResponseModel(
          statusCode: response.statusCode,
          message:
              jsonDecode(response.body)['message'] ?? 'Error Fetching Permits',
          status: 'error',
        );
      }
    } catch (e) {
      return HttpResponseModel(message: 'Error Fetching Data $e');
    }
  }

  @override
  Future<HttpResponseModel<PermitListResponse>> getLatestPermit({
    required String authToken,
  }) async {
    try {
      var url = Uri.parse('$_baseUrl/permit-letters/latest');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'Authorization': 'Bearer $authToken',
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final approvedListReponse =
            PermitListResponse.fromMap(jsonResponse as Map<String, dynamic>);
        return HttpResponseModel(
          statusCode: response.statusCode,
          data: approvedListReponse,
          status: jsonResponse['status'],
          message: jsonResponse['message'],
        );
      } else {
        return HttpResponseModel(
          statusCode: response.statusCode,
          message:
              jsonDecode(response.body)['message'] ?? 'Error Fetching Permits',
          status: 'error',
        );
      }
    } catch (e) {
      return HttpResponseModel(message: 'Error Fetching Data $e');
    }
  }

  @override
  Future<HttpResponseModel<PermitListResponse>> getPendingPermit({
    required String authToken,
  }) async {
    try {
      var url = Uri.parse('$_baseUrl/permit-letters/pending');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'Authorization': 'Bearer $authToken',
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final pendingListResponse =
            PermitListResponse.fromMap(jsonResponse as Map<String, dynamic>);
        return HttpResponseModel(
          statusCode: response.statusCode,
          data: pendingListResponse,
          status: jsonResponse['status'],
          message: jsonResponse['message'],
        );
      } else {
        return HttpResponseModel(
          statusCode: response.statusCode,
          message:
              jsonDecode(response.body)['message'] ?? 'Error Fetching Permits',
          status: 'error',
        );
      }
    } catch (e) {
      return HttpResponseModel(message: 'Error Fetching Data $e');
    }
  }

  @override
  Future<HttpResponseModel> updateDeviceToken({
    required String authToken,
    required String deviceToken,
  }) async {
    try {
      var url = Uri.parse('$_baseUrl/users/update-token');
      var response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode({
          'device_token': deviceToken,
        }),
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
