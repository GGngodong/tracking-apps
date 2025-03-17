import 'dart:convert';

class NotificationData {
  final String permitLetterId;
  final String message;
  final String type;
  final String? uploadStatus;

  NotificationData({
    required this.permitLetterId,
    required this.message,
    required this.type,
    this.uploadStatus,
  });

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(
      permitLetterId: map['permit_letter_id']?.toString() ?? '',
      message: map['message']?.toString() ?? '',
      type: map['type']?.toString() ?? '',
      uploadStatus: map['upload_status']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'permit_letter_id': permitLetterId,
      'message': message,
      'type': type,
      'upload_status': uploadStatus,
    };
  }

  String toJson() => json.encode(toMap());

  factory NotificationData.fromJson(String source) =>
      NotificationData.fromMap(json.decode(source));
}
