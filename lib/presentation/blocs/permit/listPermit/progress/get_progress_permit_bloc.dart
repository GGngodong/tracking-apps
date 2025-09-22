

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking_apps/configs/network/permit/permit_service.dart';
import 'package:tracking_apps/domain/entity/permit_model.dart';

part 'get_progress_permit_event.dart';
part 'get_progress_permit_state.dart';

class PermitLetterProgressBloc
    extends Bloc<PermitLetterProgressEvent, PermitLetterProgressState> {
  final PermitService permitService;

  PermitLetterProgressBloc({required this.permitService})
      : super(const PermitLetterProgressState()) {
    ///////////////////// Get LIST /////////////////////
    on<GetListPermitLetter>((event, state) async {
      emit(const PermitLetterProgressState(isLoading: true));
      try {
        final token = await permitService.getAuthTokenFromSP();
        if (token == null) {
          emit(PermitLetterFailedState(
              message: 'User is not authenticated. Please log in',
              isLoading: true,
              statusCode: 401));
          return;
        }
        final response = await permitService.getProgressPermit(authToken: token);
        if (response.statusCode == 200) {
          emit(PermitLetterLoadedState(
            listPermitLetter: response.data!.data,
            message: response.message,
            isLoading: false,
          ));
          print(
              '================== GET LATEST PERMIT SUCCESS ==================');
        } else {
          emit(PermitLetterFailedState(
            message: response.message ?? 'Failed to load permits',
            isLoading: false,
            statusCode: response.statusCode,
          ));
          print(
              '================== GET LATEST PERMIT FAILED ==================');
        }
      } catch (e) {
        emit(PermitLetterFailedState(
            message: e.toString(), isLoading: false, statusCode: 500));
        print(
            '================== IN GET LATEST PERMIT FAILED BLOC $e ==================');
      }
    });
  }
}
