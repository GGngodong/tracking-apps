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
  String? noPermitMabes;
  String? uploadStatus;

  PermitModel(
      {required this.id,
      required this.description,
      required this.noPermit,
      required this.date,
      required this.categoryPermit,
      required this.companyName,
      this.noPermitMabes,
      this.uploadStatus,
      required this.processStatus,
      required this.documentUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uraian': description,
      'no_surat': noPermit,
      'tanggal': date,
      'kategori_permit_letter': categoryPermit,
      'nama_pt': companyName,
      'produk_no_surat_mabes': noPermitMabes ?? '',
      'process_status': processStatus,
      'upload_status' : uploadStatus ?? '',
      'dokumen_url': documentUrl,
    };
  }

  factory PermitModel.fromMap(Map<String, dynamic> map) {
    return PermitModel(
      id: map['id'].toString(),
      description: map['uraian'] ?? 'No Description',
      noPermit: map['no_surat'] ?? 'No Nomer Permit',
      date: map['tanggal'] ?? 'No Date',
      categoryPermit: map['kategori_permit_letter'] ?? 'No Category Permit',
      companyName: map['nama_pt'] ?? 'No Company Name',
      noPermitMabes: map['produk_no_surat_mabes']?.toString(),
      documentUrl: map['dokumen_url'] ?? 'No Document Url',
      processStatus: map['status_tahapan'] ?? 'No Process Status',
      uploadStatus: map['upload_status'] ?? 'No Upload Status',
    );
  }

  String toJson() => json.encode(toMap());

  factory PermitModel.fromJson(String source) =>
      PermitModel.fromMap(json.decode(source));
}
