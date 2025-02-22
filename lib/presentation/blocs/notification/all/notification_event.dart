part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class LoadNotifications extends NotificationEvent {
  final String authToken;
  const LoadNotifications({required this.authToken});

  @override
  List<Object> get props => [authToken];
}
