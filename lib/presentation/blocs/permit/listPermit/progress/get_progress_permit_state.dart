part of 'get_progress_permit_bloc.dart';

class PermitLetterProgressState extends Equatable {
  final String? message;
  final bool isLoading;
  final int? statusCode;

  const PermitLetterProgressState({
    this.message,
    this.isLoading = false,
    this.statusCode,
  });

  @override
  List<Object?> get props => [];
}

class PermitLetterLoadingState extends PermitLetterProgressState {}

class PermitLetterFailedState extends PermitLetterProgressState {
  const PermitLetterFailedState({
    super.statusCode,
    super.message,
    super.isLoading,
  });

  @override
  List<Object?> get props => [statusCode, message, isLoading];
}

class PermitLetterLoadedState extends PermitLetterProgressState {
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
