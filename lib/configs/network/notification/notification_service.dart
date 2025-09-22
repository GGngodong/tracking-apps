import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tracking_apps/configs/network/http_response_model.dart';
import 'package:tracking_apps/configs/network/notification/notification_interface.dart';
import 'package:tracking_apps/domain/entity/notification_list_response.dart';
import 'package:tracking_apps/domain/entity/notification_model.dart';

class NotificationService extends NotificationInterface {
  final String _baseUrl = dotenv.env['BASE_URL'] ?? "";
  final String _devUrl = dotenv.env['DEV_URL'] ?? "";
  final apiKey = dotenv.env['X_API_KEY'] ?? '';

  @override
  Future<HttpResponseModel<NotificationListResponse>> getNotification(
      {required String authToken}) async {
    try {
      final url = Uri.parse('$_devUrl/notifications');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Accept': 'application/json;charset=UTF-8',
          'X-API-KEY': apiKey,
          'Authorization': 'Bearer $authToken',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final data = jsonResponse['data'] as Map<String, dynamic>;
        final notificationListResponse = NotificationListResponse.fromMap(data);
        return HttpResponseModel<NotificationListResponse>(
          statusCode: response.statusCode,
          data: notificationListResponse,
          status: jsonResponse['status'],
          message: jsonResponse['message'],
        );
      } else {
        return HttpResponseModel<NotificationListResponse>(
          statusCode: response.statusCode,
          message: jsonDecode(response.body)['message'] ??
              'Error fetching notifications',
          status: 'error',
        );
      }
    } catch (e) {
      return HttpResponseModel<NotificationListResponse>(
        message: 'An error occurred: $e',
      );
    }
  }

  @override
  Future<HttpResponseModel> markNotificationAsRead({
    required String authToken,
    required String notificationId,
  }) async {
    try {
      final url = Uri.parse('$_devUrl/notifications/$notificationId/read');
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'X-API-KEY': apiKey,
          'Authorization': 'Bearer $authToken',
        },
      );
      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)['data'],
        status: jsonDecode(response.body)['status'],
        message: jsonDecode(response.body)['message'],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }

  @override
  Future<HttpResponseModel> detailNotification({
    required String authToken,
    required String notificationId,
  }) async {
    try {
      final url = Uri.parse('$_devUrl/notifications/$notificationId');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Accept': 'application/json;charset=UTF-8',
          'X-API-KEY': apiKey,
          'Authorization': 'Bearer $authToken',
        },
      );
      final jsonResponse = jsonDecode(response.body);
      final notificationDetail =
          NotificationModel.fromMap(jsonResponse['data']);
      return HttpResponseModel(
        statusCode: response.statusCode,
        data: notificationDetail,
        status: jsonResponse['status'],
        message: jsonResponse['message'],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }

  @override
  Future<HttpResponseModel> deleteNotification({
    required String authToken,
    required String notificationId,
  }) async {
    try {
      final url = Uri.parse('$_devUrl/notifications/delete/$notificationId');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'X-API-KEY': apiKey,
          'Authorization': 'Bearer $authToken',
        },
      );
      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)['data'],
        status: jsonDecode(response.body)['status'],
        message: jsonDecode(response.body)['message'],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }
}
