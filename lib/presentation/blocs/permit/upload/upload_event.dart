part of 'upload_bloc.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object?> get props => [];
}

class UploadButtonPressed extends UploadEvent {
  final String description;
  final String noPermit;
  final String date;
  final String categoryPermit;
  final String companyName;
  final String? noPermitMabes;
  final String documentUrl;

  const UploadButtonPressed({
    required this.description,
    required this.noPermit,
    required this.date,
    required this.categoryPermit,
    required this.companyName,
    this.noPermitMabes,
    required this.documentUrl,
  });

  @override
  List<Object?> get props => [
        description,
        noPermit,
        date,
        categoryPermit,
        companyName,
        noPermitMabes,
        documentUrl,
      ];
}

class ClearDataUpload extends UploadEvent {
  const ClearDataUpload();

  @override
  List<Object?> get props => [];
}
