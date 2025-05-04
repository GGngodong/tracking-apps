part of 'get_pending_permit_bloc.dart';

abstract class PermitLetterPendingEvent extends Equatable {
  const PermitLetterPendingEvent();

  @override
  List<Object?> get props => [];
}

class GetListPermitLetter extends PermitLetterPendingEvent {}

