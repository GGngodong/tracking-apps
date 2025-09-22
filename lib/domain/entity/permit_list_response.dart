import 'dart:convert';

import 'package:tracking_apps/domain/entity/permit_model.dart';

class PermitListResponse {
  late final List<PermitModel> data;

  PermitListResponse({required this.data});

  factory PermitListResponse.fromMap(Map<String, dynamic> map) {
    return PermitListResponse(
      data: List<PermitModel>.from(
        (map['data'] as List).map((x) => PermitModel.fromMap(x)),
      ),
    );
  }

  factory PermitListResponse.fromJson(String source) =>
      PermitListResponse.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}
