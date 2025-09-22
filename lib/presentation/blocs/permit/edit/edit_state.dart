part of 'edit_bloc.dart';

class EditState extends Equatable {
  final String? message;
  final bool isLoading;
  final int? statusCode;

  const EditState({
    this.message,
    this.isLoading = false,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, isLoading, statusCode];
}

class EditLoadingState extends EditState {}

class EditSuccessState extends EditState {
  final PermitModel permit;

  const EditSuccessState({
    required this.permit,
    super.message,
    super.isLoading,
    super.statusCode,
  });

  @override
  List<Object?> get props => [permit, message, isLoading, statusCode];
}

class EditFailedState extends EditState {
  const EditFailedState({
    super.message,
    super.isLoading,
    super.statusCode,
  });

  @override
  List<Object?> get props => [message, isLoading, statusCode];
}

class DeleteSuccessState extends EditState {
  const DeleteSuccessState({
    super.message,
    super.isLoading,
    super.statusCode,
  });

  @override
  List<Object?> get props => [message, isLoading, statusCode];
}
