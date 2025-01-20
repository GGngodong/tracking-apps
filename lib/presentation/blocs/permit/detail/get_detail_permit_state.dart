part of 'get_detail_permit.bloc.dart';

class DetailPermitLetterState extends Equatable {
  final String? message;
  final bool isLoading;
  final int? statusCode;

  const DetailPermitLetterState({
    this.message,
    this.isLoading = false,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, isLoading, statusCode];
}

class DetailPermitLetterLoadingState extends DetailPermitLetterState {}

class DetailPermitLetterLoadedState extends DetailPermitLetterState {
  final PermitModel permit;

  const DetailPermitLetterLoadedState({
    required this.permit,
    super.message,
    super.isLoading,
    super.statusCode,
  });

  @override
  List<Object?> get props => [permit, message, isLoading, statusCode];
}

class DetailPermitLetterFailedState extends DetailPermitLetterState {

  const DetailPermitLetterFailedState({
    super.statusCode,
    super.message,
    super.isLoading,
  });

  @override
  List<Object?> get props => [message, isLoading, statusCode];
}