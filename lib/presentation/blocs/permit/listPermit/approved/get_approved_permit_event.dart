part of 'get_approved_permit_bloc.dart';

abstract class PermitLetterApprovedEvent extends Equatable {
  const PermitLetterApprovedEvent();

  @override
  List<Object?> get props => [];
}

class GetListPermitLetter extends PermitLetterApprovedEvent {}
