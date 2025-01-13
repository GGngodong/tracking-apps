import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/src/intl/date_format.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/network/http_response_model.dart';
import 'package:tracking_apps/configs/network/user_interface.dart';
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
  Future<HttpResponseModel> check({required String email}) async {
    try {
      var url = Uri.parse('$_baseUrl/users/check/$email');
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
  Future<HttpResponseModel> updatePassword(
      {required String userId, required String password}) async {
    try {
      var url = Uri.parse('$_baseUrl/users/$userId');
      var response = await http.put(
        url,
        body: jsonEncode({
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
  Future<HttpResponseModel> createPermit({
    required String description,
    required String noLetter,
    required String categoryPermit,
    required String companyName,
    required DateFormat date,
    required String productNoMabes,
    required String document,
  }) async {
    try {
      var url = Uri.parse('$_baseUrl/dev/permit-letters/upload');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
        },
        body: jsonEncode({
          'uraian': description,
          'no_surat': noLetter,
          'kategori_permit_letter': categoryPermit,
          'nama_pt': companyName,
          'tanggal': date,
          'produk_no_surat_mabes': productNoMabes,
          'dokumen': document
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
