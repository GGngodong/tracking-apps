part of 'edit_bloc.dart';

abstract class EditEvent extends Equatable {
  const EditEvent();

  @override
  List<Object?> get props => [];
}

class UpdateDataButtonPressed extends EditEvent {
  String? processStatus;
  String? uploadStatus;
  String? noProdukMabes;
  String? note;
  String? documentUrl;
  final String id;

  UpdateDataButtonPressed({
    this.note,
    this.noProdukMabes,
    this.processStatus,
    this.uploadStatus,
    this.documentUrl,
    required this.id,
  });

  @override
  List<Object?> get props =>
      [note, noProdukMabes, processStatus, uploadStatus, id, documentUrl];
}

class DeleteDataButtonPressed extends EditEvent {
  final String id;

  const DeleteDataButtonPressed({required this.id});

  @override
  List<Object?> get props => [id];
}
