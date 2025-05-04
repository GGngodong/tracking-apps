part of 'get_approved_permit_bloc.dart';

class PermitLetterApprovedState extends Equatable {
  final String? message;
  final bool isLoading;
  final int? statusCode;

  const PermitLetterApprovedState({
    this.message,
    this.isLoading = false,
    this.statusCode,
  });

  @override
  List<Object?> get props => [];
}

class PermitLetterLoadingState extends PermitLetterApprovedState {}

class PermitLetterFailedState extends PermitLetterApprovedState {
  const PermitLetterFailedState({
    super.statusCode,
    super.message,
    super.isLoading,
  });

  @override
  List<Object?> get props => [statusCode, message, isLoading];
}

class PermitLetterLoadedState extends PermitLetterApprovedState {
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
