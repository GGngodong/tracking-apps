part of 'notification_edit_bloc.dart';

abstract class NotificationEditEvent extends Equatable {
  const NotificationEditEvent();

  @override
  List<Object> get props => [];
}

class MarkNotificationAsReadEvent extends NotificationEditEvent {
  final String authToken;
  final String notificationId;
  const MarkNotificationAsReadEvent({
    required this.authToken,
    required this.notificationId,
  });

  @override
  List<Object> get props => [authToken, notificationId];
}

class DeleteNotificationEvent extends NotificationEditEvent {
  final String authToken;
  final String notificationId;
  const DeleteNotificationEvent({
    required this.authToken,
    required this.notificationId,
  });

  @override
  List<Object> get props => [authToken, notificationId];
}

