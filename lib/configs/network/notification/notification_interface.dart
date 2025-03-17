import 'package:tracking_apps/configs/network/http_response_model.dart';
import 'package:tracking_apps/domain/entity/notification_list_response.dart';

abstract class NotificationInterface {
  Future<HttpResponseModel<NotificationListResponse>> getNotification({
    required String authToken,
  });

  Future<HttpResponseModel> markNotificationAsRead({
    required String authToken,
    required String notificationId,
  });

  Future<HttpResponseModel> detailNotification({
    required String authToken,
    required String notificationId,
  });

  Future<HttpResponseModel> deleteNotification({
    required String authToken,
    required String notificationId,
  });
}
