part of 'notification_detail_bloc.dart';

abstract class NotificationDetailState extends Equatable {
  const NotificationDetailState();

  @override
  List<Object> get props => [];
}

class NotificationDetailInitial extends NotificationDetailState {}

class NotificationDetailLoading extends NotificationDetailState {}

class NotificationDetailSuccess extends NotificationDetailState {
  final NotificationModel notificationDetail;

  const NotificationDetailSuccess({required this.notificationDetail});

  @override
  List<Object> get props => [notificationDetail];
}

class NotificationDetailFailure extends NotificationDetailState {
  final String error;

  const NotificationDetailFailure({required this.error});

  @override
  List<Object> get props => [error];
}
