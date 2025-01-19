part of 'get_permit_bloc.dart';

class PermitLetterState extends Equatable {
  final String? message;
  final bool isLoading;
  final int? statusCode;

  const PermitLetterState({
    this.message,
    this.isLoading = false,
    this.statusCode,
  });

  @override
  List<Object?> get props => [];
}

class PermitLetterLoadingState extends PermitLetterState {}

class PermitLetterFailedState extends PermitLetterState {
  const PermitLetterFailedState({
    super.statusCode,
    super.message,
    super.isLoading,
  });

  @override
  List<Object?> get props => [statusCode, message, isLoading];
}

class PermitLetterLoadedState extends PermitLetterState {
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
