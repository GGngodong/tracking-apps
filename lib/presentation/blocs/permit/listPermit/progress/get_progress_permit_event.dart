part of 'get_progress_permit_bloc.dart';

abstract class PermitLetterProgressEvent extends Equatable {
  const PermitLetterProgressEvent();

  @override
  List<Object?> get props => [];
}

class GetListPermitLetter extends PermitLetterProgressEvent {}
