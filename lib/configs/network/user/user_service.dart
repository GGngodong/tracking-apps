import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/network/http_response_model.dart';
import 'package:tracking_apps/configs/network/user/user_interface.dart';
import 'package:tracking_apps/domain/entity/user_model.dart';
import 'package:tracking_apps/network/api_client.dart';

class UserService extends UserInterface {
  final String _baseUrl = dotenv.env['BASE_URL'] ?? "";
  final String _devUrl = dotenv.env['DEV_URL'] ?? "";

  @override
  Future<HttpResponseModel> login(
      {required String email, required String password}) async {
    try {
      final url = Uri.parse('$_devUrl/users/login');
      final response = await ApiClient.request((headers) {
        return http.post(
          url,
          headers: headers,
          body: jsonEncode({'email': email, 'password': password}),
        );
      });
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
      final url = Uri.parse('$_devUrl/users/forgot-password');
      final response = await ApiClient.request((headers) {
        return http.post(
          url,
          headers: headers,
          body: jsonEncode({
            'email': email,
          }),
        );
      });

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
      final url = Uri.parse('$_devUrl/users');
      final response = await ApiClient.request((headers) {
        return http.post(
          url,
          headers: headers,
          body: jsonEncode({
            'username': username,
            'email': email,
            'password': password,
            'division': division,
          }),
        );
      });

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
      final url = Uri.parse('$_devUrl/users/logout');
      final response = await ApiClient.request((headers) {
        return http.delete(
          url,
          headers: headers,
        );
      });

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
      final url = Uri.parse('$_devUrl/users/$id');
      final response = await ApiClient.request((headers) {
        return http.get(
          url,
          headers: headers,
        );
      });

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
    final url = Uri.parse('$_devUrl/users/current');
    try {
      final response = await ApiClient.request((headers) {
        return http.get(url, headers: {
          ...headers,
          'Authorization': 'Bearer $token',
        });
      });
      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)["data"],
        message: jsonDecode(response.body)["message"],
      );
    } catch (e) {
      return HttpResponseModel(
        statusCode: 401,
        message: 'Session expired or network error',
      );
    }
  }

  @override
  Future<HttpResponseModel> update({required UserModel userModel}) async {
    try {
      final url = Uri.parse('$_devUrl/users/${userModel.id}');
      final response = await ApiClient.request((headers) {
        return http.put(
          url,
          headers: headers,
          body: jsonEncode({
            'username': userModel.userName,
            'email': userModel.email,
            'division': userModel.division,
          }),
        );
      });

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
  Future<HttpResponseModel> updateDeviceToken({
    required String authToken,
    required String deviceToken,
  }) async {
    try {
      final url = Uri.parse('$_devUrl/users/update-token');
      final response = await ApiClient.request((headers) {
        return http.patch(
          url,
          headers: headers,
          body: jsonEncode({
            'device_token': deviceToken,
          }),
        );
      });

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
