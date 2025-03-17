part of 'get_latest_permit_bloc.dart';

abstract class PermitLetterLatestEvent extends Equatable {
  const PermitLetterLatestEvent();

  @override
  List<Object?> get props => [];
}

class GetListPermitLetter extends PermitLetterLatestEvent {}

