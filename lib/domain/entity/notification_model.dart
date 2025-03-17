import 'dart:convert';

import 'notification_data.dart';

class NotificationModel {
  String id;
  String type;
  String notifiableType;
  int notifiableId;
  NotificationData data;
  DateTime? readAt;
  DateTime createdAt;
  DateTime updatedAt;

  NotificationModel({
    required this.id,
    required this.type,
    required this.notifiableType,
    required this.notifiableId,
    required this.data,
    this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as String,
      type: map['type'] as String,
      notifiableType: map['notifiable_type'] as String,
      notifiableId: map['notifiable_id'] is int
          ? map['notifiable_id'] as int
          : int.parse(map['notifiable_id'].toString()),
      data: NotificationData.fromMap(map['data'] as Map<String, dynamic>),
      readAt: map['read_at'] != null ? DateTime.parse(map['read_at']) : null,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'notifiable_type': notifiableType,
      'notifiable_id': notifiableId,
      'data': data.toMap(),
      'read_at': readAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));
}
