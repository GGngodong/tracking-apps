part of 'get_reject_permit_bloc.dart';

abstract class PermitLetterRejectEvent extends Equatable {
  const PermitLetterRejectEvent();

  @override
  List<Object?> get props => [];
}

class GetListPermitLetter extends PermitLetterRejectEvent {}
