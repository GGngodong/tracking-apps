import 'dart:convert';

import 'package:tracking_apps/domain/entity/permit_log_model.dart';

class PermitLogListResponse {
  final List<PermitLogModel> data;

  PermitLogListResponse({required this.data});

  factory PermitLogListResponse.fromMap(Map<String, dynamic> map) {
    return PermitLogListResponse(
      data: List<PermitLogModel>.from(
        (map['data'] as List)
            .map((x) => PermitLogModel.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }

  factory PermitLogListResponse.fromJson(String source) =>
      PermitLogListResponse.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}
