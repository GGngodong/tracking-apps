part of 'get_pending_permit_bloc.dart';

class PermitLetterPendingState extends Equatable {
  final String? message;
  final bool isLoading;
  final int? statusCode;

  const PermitLetterPendingState({
    this.message,
    this.isLoading = false,
    this.statusCode,
  });

  @override
  List<Object?> get props => [];
}

class PermitLetterLoadingState extends PermitLetterPendingState {}

class PermitLetterFailedState extends PermitLetterPendingState {
  const PermitLetterFailedState({
    super.statusCode,
    super.message,
    super.isLoading,
  });

  @override
  List<Object?> get props => [statusCode, message, isLoading];
}

class PermitLetterLoadedState extends PermitLetterPendingState {
  final List<PermitModel> listPermitLetter;

  const PermitLetterLoadedState({
    required this.listPermitLetter,
    super.statusCode,
    super.message,
    super.isLoading,
  });

  @override
  List<Object?> get props => [listPermitLetter, statusCode, message, isLoading];
}
