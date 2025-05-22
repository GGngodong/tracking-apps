import 'dart:convert';

class PermitModel {
  String id;
  String description;
  String noPermit;
  String date;
  String categoryPermit;
  String companyName;
  String documentUrl;
  String processStatus;
  String categoryAdministration;
  String? note;
  String? noPermitMabes;
  String? uploadStatus;
  String? releasedDocumentUrl;

  PermitModel({
    required this.id,
    required this.description,
    required this.noPermit,
    required this.date,
    required this.categoryPermit,
    required this.companyName,
    required this.categoryAdministration,
    required this.processStatus,
    required this.documentUrl,
    this.note,
    this.noPermitMabes,
    this.uploadStatus,
    this.releasedDocumentUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uraian': description,
      'no_surat': noPermit,
      'tanggal': date,
      'kategori_permit_letter': categoryPermit,
      'nama_pt': companyName,
      'sub_kategori_permit_letter': categoryAdministration,
      'produk_no_surat_mabes': noPermitMabes ?? '',
      'process_status': processStatus,
      'upload_status': uploadStatus ?? '',
      'dokumen_url': documentUrl,
      'released_dokumen_url': releasedDocumentUrl ?? '',
      'note': note ?? '',
    };
  }

  factory PermitModel.fromMap(Map<String, dynamic> map) {
    return PermitModel(
      id: map['id'].toString(),
      description: map['uraian'] ?? 'No Description',
      noPermit: map['no_surat'] ?? 'No Nomer Permit',
      date: map['tanggal'] ?? 'No Date',
      categoryPermit: map['kategori_permit_letter'] ?? 'No Category Permit',
      categoryAdministration:
          map['sub_kategori_permit_letter'] ?? 'No Sub Category Permit',
      companyName: map['nama_pt'] ?? 'No Company Name',
      noPermitMabes: map['produk_no_surat_mabes']?.toString(),
      documentUrl: map['dokumen_url'] ?? 'No Document Url',
      releasedDocumentUrl: map['released_dokumen_url'] ?? 'No Released Document Url',
      processStatus: map['status_tahapan'] ?? 'No Process Status',
      uploadStatus: map['upload_status'] ?? 'No Upload Status',
      note: map['note'] ?? 'No notes',
    );
  }

  String toJson() => json.encode(toMap());

  factory PermitModel.fromJson(String source) =>
      PermitModel.fromMap(json.decode(source));
}
