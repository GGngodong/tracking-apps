part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoadSuccess extends NotificationState {
  final NotificationListResponse notificationListResponse;

  const NotificationLoadSuccess({required this.notificationListResponse});

  @override
  List<Object> get props => [notificationListResponse];
}

class NotificationLoadFailure extends NotificationState {
  final String error;

  const NotificationLoadFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class MarkNotificationFailure extends NotificationState {
  final String error;

  const MarkNotificationFailure({required this.error});

  @override
  List<Object> get props => [error];
}
