import 'dart:convert';

import 'package:tracking_apps/domain/entity/notification_model.dart';

class NotificationListResponse {
  List<NotificationModel> notifications;
  int unreadCount;

  NotificationListResponse({
    required this.notifications,
    required this.unreadCount,
  });

  factory NotificationListResponse.fromMap(Map<String, dynamic> map) {
    return NotificationListResponse(
      notifications: List<NotificationModel>.from(
        (map['notifications'] as List).map(
          (x) => NotificationModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      unreadCount: map['unread_count'] is int
          ? map['unread_count'] as int
          : int.parse(map['unread_count'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notifications': notifications.map((x) => x.toMap()).toList(),
      'unread_count': unreadCount,
    };
  }

  String toJson() => json.encode(toMap());

  factory NotificationListResponse.fromJson(String source) =>
      NotificationListResponse.fromMap(json.decode(source));
}
