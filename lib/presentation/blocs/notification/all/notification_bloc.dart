import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking_apps/configs/network/http_response_model.dart';
import 'package:tracking_apps/configs/network/notification/notification_service.dart';
import 'package:tracking_apps/domain/entity/notification_list_response.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationService notificationService;

  NotificationBloc({required this.notificationService})
      : super(NotificationInitial()) {
    on<LoadNotifications>((event, emit) async {
      emit(NotificationLoading());
      try {
        HttpResponseModel<NotificationListResponse> response =
            await notificationService.getNotification(
                authToken: event.authToken);
        if (response.status == 'success' && response.data != null) {
          emit(
            NotificationLoadSuccess(notificationListResponse: response.data!),
          );
        } else {
          emit(
            NotificationLoadFailure(error: response.message ?? 'Unknown error'),
          );
        }
      } catch (e) {
        emit(NotificationLoadFailure(error: e.toString()));
      }
    });
  }
}
