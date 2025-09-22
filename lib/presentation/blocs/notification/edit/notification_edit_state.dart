part of 'notification_edit_bloc.dart';

abstract class NotificationEditState extends Equatable {
  const NotificationEditState();

  @override
  List<Object> get props => [];
}

class NotificationEditInitial extends NotificationEditState {}

class NotificationEditLoading extends NotificationEditState {}

class MarkNotificationSuccess extends NotificationEditState {
  final String message;

  const MarkNotificationSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class MarkNotificationFailure extends NotificationEditState {
  final String error;

  const MarkNotificationFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class DeleteNotificationSuccess extends NotificationEditState {
  final String message;

  const DeleteNotificationSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteNotificationFailure extends NotificationEditState {
  final String error;

  const DeleteNotificationFailure({required this.error});

  @override
  List<Object> get props => [error];
}
