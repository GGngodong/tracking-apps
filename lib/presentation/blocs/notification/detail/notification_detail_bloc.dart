import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking_apps/configs/network/http_response_model.dart';
import 'package:tracking_apps/configs/network/notification/notification_service.dart';
import 'package:tracking_apps/domain/entity/notification_model.dart';

part 'notification_detail_event.dart';
part 'notification_detail_state.dart';

class NotificationDetailBloc extends Bloc<NotificationDetailEvent, NotificationDetailState> {
  final NotificationService notificationService;

  NotificationDetailBloc({required this.notificationService})
      : super(NotificationDetailInitial()) {
    on<LoadNotificationDetail>(_onLoadNotificationDetail);
  }

  Future<void> _onLoadNotificationDetail(
      LoadNotificationDetail event, Emitter<NotificationDetailState> emit) async {
    emit(NotificationDetailLoading());
    try {
      HttpResponseModel response = await notificationService.detailNotification(
        authToken: event.authToken,
        notificationId: event.notificationId,
      );
      if (response.status == 'success' && response.data != null) {
        final notificationDetail = response.data as NotificationModel;
        emit(NotificationDetailSuccess(notificationDetail: notificationDetail));
      } else {
        emit(NotificationDetailFailure(
            error: response.message ?? 'Error loading notification detail'));
      }
    } catch (e) {
      emit(NotificationDetailFailure(error: e.toString()));
    }
  }
}
