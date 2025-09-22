import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking_apps/configs/network/permit/permit_service.dart';
import 'package:tracking_apps/domain/entity/permit_log_model.dart';

part 'get_logs_permit_event.dart';

part 'get_logs_permit_state.dart';

class PermitLetterLogBloc
    extends Bloc<PermitLetterLogsEvent, PermitLetterLogState> {
  final PermitService permitService;

  PermitLetterLogBloc({required this.permitService})
      : super(const PermitLetterLogState()) {
    on<GetPermitLettersLogEvent>((event, state) async {
      emit(const PermitLetterLogState(isLoading: true));
      try {
        final token = await permitService.getAuthTokenFromSP();
        if (token == null) {
          emit(PermitLetterLogFailedState(
              message: 'User is not authenticated. Please log in',
              isLoading: true,
              statusCode: 401));
          return;
        }
        final response =
            await permitService.getPermitLogs(authToken: token, id: event.id);
        if (response.statusCode == 200 && response.data != null) {
          emit(
            PermitLetterLogLoadedState(
              listPermitLog: response.data!.data,
              message: response.message,
              isLoading: false,
            ),
          );
          print('================== GET PERMIT LOG SUCCESS ==================');
        }
      } catch (e) {
        emit(PermitLetterLogFailedState(
            message: e.toString(), isLoading: false, statusCode: 500));
        print(
            '================== IN GET PERMIT LOG FAILED BLOC ==================');
      }
    });
  }
}
