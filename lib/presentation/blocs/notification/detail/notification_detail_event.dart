part of 'notification_detail_bloc.dart';

abstract class NotificationDetailEvent extends Equatable {
  const NotificationDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadNotificationDetail extends NotificationDetailEvent {
  final String authToken;
  final String notificationId;

  const LoadNotificationDetail({
    required this.authToken,
    required this.notificationId,
  });

  @override
  List<Object> get props => [authToken, notificationId];
}
