part of 'edit_bloc.dart';

abstract class EditEvent extends Equatable {
  const EditEvent();

  @override
  List<Object?> get props => [];
}

class UpdateDataButtonPressed extends EditEvent {
  String? processStatus;
  final String id;

  UpdateDataButtonPressed({this.processStatus, required this.id});

  @override
  List<Object?> get props => [processStatus, id];
}

class DeleteDataButtonPressed extends EditEvent {
  final String id;

  const DeleteDataButtonPressed({required this.id});

  @override
  List<Object?> get props => [id];
}