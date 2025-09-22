class PermitLogModel {
  final String id;
  final String permitLetterId;
  final String statusTahapan;
  final String description;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  PermitLogModel({
    required this.id,
    required this.permitLetterId,
    required this.statusTahapan,
    required this.description,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'permit_letter_id': permitLetterId,
      'status_tahapan': statusTahapan,
      'description': description,
      'updated_by': updatedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory PermitLogModel.fromMap(Map<String, dynamic> map) {
    return PermitLogModel(
      id: map['id'].toString(),
      permitLetterId: map['permit_letter_id'].toString(),
      statusTahapan: map['status_tahapan'] ?? '',
      description: map['description'] ?? '',
      updatedBy: map['updated_by'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }
}
