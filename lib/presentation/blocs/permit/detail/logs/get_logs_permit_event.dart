part of 'get_logs_permit_bloc.dart';

abstract class PermitLetterLogsEvent extends Equatable {
  const PermitLetterLogsEvent();

  @override
  List<Object?> get props => [];
}

class GetPermitLettersLogEvent extends PermitLetterLogsEvent {
  final String id;

  const GetPermitLettersLogEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
