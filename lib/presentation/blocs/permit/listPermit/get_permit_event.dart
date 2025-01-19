part of 'get_permit_bloc.dart';

abstract class PermitLetterEvent extends Equatable {
  const PermitLetterEvent();

  @override
  List<Object?> get props => [];
}

class GetPermitLetter extends PermitLetterEvent {}