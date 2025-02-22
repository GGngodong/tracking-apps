import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_apps/configs/network/http_response_model.dart';
import 'package:tracking_apps/configs/network/notification/notification_service.dart';

part 'notification_edit_event.dart';

part 'notification_edit_state.dart';

class NotificationEditBloc
    extends Bloc<NotificationEditEvent, NotificationEditState> {
  final NotificationService notificationService;

  NotificationEditBloc({required this.notificationService})
      : super(NotificationEditInitial()) {
    on<MarkNotificationAsReadEvent>((event, emit) async {
      emit(NotificationEditLoading());
      try {
        HttpResponseModel markResponse =
        await notificationService.markNotificationAsRead(
          authToken: event.authToken,
          notificationId: event.notificationId,
        );
        if (markResponse.status == 'success') {
          emit(MarkNotificationSuccess(
              message: markResponse.message ?? 'Notification marked as read'));
        } else {
          emit(MarkNotificationFailure(
              error: markResponse.message ??
                  'Error marking notification as read'));
        }
      } catch (e) {
        emit(MarkNotificationFailure(error: e.toString()));
      }
    });

    on<DeleteNotificationEvent>((event, emit) async {
      emit(NotificationEditLoading());
      try {
        HttpResponseModel deleteResponse =
        await notificationService.deleteNotification(
          authToken: event.authToken,
          notificationId: event.notificationId,
        );
        if (deleteResponse.status == 'success') {
          emit(DeleteNotificationSuccess(
              message: deleteResponse.message ?? 'Notification deleted'));
        } else {
          emit(DeleteNotificationFailure(
              error: deleteResponse.message ?? 'Error deleting notification'));
        }
      } catch (e) {
        emit(DeleteNotificationFailure(error: e.toString()));
      }
    });
  }
}