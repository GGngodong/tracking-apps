part of 'get_detail_permit_bloc.dart';

abstract class DetailPermitLetterEvent extends Equatable {
  const DetailPermitLetterEvent();

  @override
  List<Object?> get props => [];
}

class GetDetailPermitLetterEvent extends DetailPermitLetterEvent {
  final String id;

  const GetDetailPermitLetterEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
