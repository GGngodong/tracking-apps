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

class UpdateDataButtonPressed extends UploadEvent {
  final String description;
  final String noPermit;
  final String categoryPermit;
  final String companyName;
  final String noPermitMabes;

  const UpdateDataButtonPressed({
    required this.description,
    required this.noPermit,
    required this.categoryPermit,
    required this.companyName,
    required this.noPermitMabes,
  });

  @override
  List<Object?> get props => [
        description,
        noPermit,
        categoryPermit,
        companyName,
        noPermitMabes,
      ];
}

class DeleteDataButtonPressed extends UploadEvent {
  const DeleteDataButtonPressed();

  @override
  List<Object?> get props => [];
}

class ClearDataUpload extends UploadEvent {
  const ClearDataUpload();

  @override
  List<Object?> get props => [];
}
