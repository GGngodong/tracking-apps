import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking_apps/configs/network/user_service.dart';
import 'package:tracking_apps/domain/entity/permit_model.dart';

part 'get_pending_permit_event.dart';

part 'get_pending_permit_state.dart';

class PermitLetterPendingBloc extends Bloc<PermitLetterPendingEvent, PermitLetterPendingState> {
  final UserService userService;

  PermitLetterPendingBloc({required this.userService})
      : super(const PermitLetterPendingState()) {
    ///////////////////// Get LIST /////////////////////
    on<GetListPermitLetter>((event, state) async {
      emit(const PermitLetterPendingState(isLoading: true));
      try {
        final token = await userService.getAuthTokenFromSP();
        if (token == null) {
          emit(PermitLetterFailedState(
              message: 'User is not authenticated. Please log in',
              isLoading: true,
              statusCode: 401));
          return;
        }
        final response = await userService.getPendingPermit(authToken: token);
        if (response.statusCode == 200) {
          emit(PermitLetterLoadedState(
            listPermitLetter: response.data!.data,
            message: response.message,
            isLoading: false,
          ));
          print('================== GET PENDING PERMIT SUCCESS ==================');
        } else {
          emit(PermitLetterFailedState(
            message: response.message ?? 'Failed to load permits',
            isLoading: false,
            statusCode: response.statusCode,
          ));
          print('================== GET PENDING PERMIT FAILED ==================');
        }
      } catch (e) {
        emit(PermitLetterFailedState(
            message: e.toString(), isLoading: false, statusCode: 500));
        print(
            '================== IN GET PENDING PERMIT FAILED BLOC $e ==================');
      }
    });
  }
}
