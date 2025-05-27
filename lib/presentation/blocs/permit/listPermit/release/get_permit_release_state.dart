part of 'get_permit_release_bloc.dart';

class PermitLetterReleaseState extends Equatable {
  final String? message;
  final bool isLoading;
  final int? statusCode;

  const PermitLetterReleaseState({
    this.message,
    this.isLoading = false,
    this.statusCode,
  });

  @override
  List<Object?> get props => [];
}

class PermitLetterLoadingState extends PermitLetterReleaseState {}

class PermitLetterFailedState extends PermitLetterReleaseState {
  const PermitLetterFailedState({
    super.statusCode,
    super.message,
    super.isLoading,
  });

  @override
  List<Object?> get props => [statusCode, message, isLoading];
}

class PermitLetterLoadedState extends PermitLetterReleaseState {
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
