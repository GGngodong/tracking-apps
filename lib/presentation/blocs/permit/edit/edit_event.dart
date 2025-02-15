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
  final String id;

  UpdateDataButtonPressed({
    this.noProdukMabes,
    this.processStatus,
    this.uploadStatus,
    required this.id,
  });

  @override
  List<Object?> get props => [noProdukMabes, processStatus, uploadStatus, id];
}

class DeleteDataButtonPressed extends EditEvent {
  final String id;

  const DeleteDataButtonPressed({required this.id});

  @override
  List<Object?> get props => [id];
}
