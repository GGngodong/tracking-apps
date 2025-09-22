part of 'get_logs_permit_bloc.dart';

class PermitLetterLogState extends Equatable {
  final String? message;
  final bool isLoading;
  final int? statusCode;

  const PermitLetterLogState({
    this.message,
    this.isLoading = false,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, isLoading, statusCode];
}

class PermitLetterLogLoadingState extends PermitLetterLogState {}

class PermitLetterLogLoadedState extends PermitLetterLogState {
  final List<PermitLogModel> listPermitLog;

  const PermitLetterLogLoadedState({
    required this.listPermitLog,
    super.message,
    super.isLoading,
    super.statusCode,
  });

  @override
  List<Object?> get props => [listPermitLog, message, isLoading, statusCode];
}

class PermitLetterLogFailedState extends PermitLetterLogState {
  const PermitLetterLogFailedState({
    super.statusCode,
    super.message,
    super.isLoading,
  });

  @override
  List<Object?> get props => [message, isLoading, statusCode];
}
