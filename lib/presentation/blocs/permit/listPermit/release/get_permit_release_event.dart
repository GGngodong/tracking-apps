part of 'get_permit_release_bloc.dart';

abstract class PermitLetterReleaseEvent extends Equatable {
  const PermitLetterReleaseEvent();

  @override
  List<Object?> get props => [];
}

class GetListPermitLetter extends PermitLetterReleaseEvent {}
