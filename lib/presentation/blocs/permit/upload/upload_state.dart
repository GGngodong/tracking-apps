part of 'upload_bloc.dart';

class UploadState extends Equatable {
  final String? message;
  final bool isLoading;
  final int? statusCode;

  const UploadState({
    this.message,
    this.isLoading = false,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, isLoading, statusCode];
}

class UploadSuccess extends UploadState {
  final PermitModel permit;

  const UploadSuccess({
    required this.permit,
    super.message,
    super.isLoading,
    super.statusCode,
  });

  @override
  List<Object?> get props => [permit, message, isLoading, statusCode];
}

class UploadFailed extends UploadState {
  const UploadFailed({
    super.message,
    super.isLoading,
    super.statusCode,
  });

  @override
  List<Object?> get props => [message, isLoading, statusCode];
}

