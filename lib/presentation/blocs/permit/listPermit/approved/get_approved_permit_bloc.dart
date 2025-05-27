import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking_apps/configs/network/permit/permit_service.dart';
import 'package:tracking_apps/domain/entity/permit_model.dart';

part 'get_approved_permit_event.dart';
part 'get_approved_permit_state.dart';

class PermitLetterApprovedBloc
    extends Bloc<PermitLetterApprovedEvent, PermitLetterApprovedState> {
  final PermitService permitService;

  PermitLetterApprovedBloc({required this.permitService})
      : super(const PermitLetterApprovedState()) {
    ///////////////////// Get LIST /////////////////////
    on<GetListPermitLetter>((event, state) async {
      emit(const PermitLetterApprovedState(isLoading: true));
      try {
        final token = await permitService.getAuthTokenFromSP();
        if (token == null) {
          emit(PermitLetterFailedState(
              message: 'User is not authenticated. Please log in',
              isLoading: true,
              statusCode: 401));
          return;
        }
        final response =
            await permitService.getApprovedPermit(authToken: token);
        if (response.statusCode == 200) {
          emit(PermitLetterLoadedState(
            listPermitLetter: response.data!.data,
            message: response.message,
            isLoading: false,
          ));
          print(
              '================== GET APPROVED PERMIT SUCCESS ==================');
        } else {
          emit(PermitLetterFailedState(
            message: response.message ?? 'Failed to load permits',
            isLoading: false,
            statusCode: response.statusCode,
          ));
          print(
              '================== GET APPROVED PERMIT FAILED ==================');
        }
      } catch (e) {
        emit(PermitLetterFailedState(
            message: e.toString(), isLoading: false, statusCode: 500));
        print(
            '================== IN GET APPROVED PERMIT FAILED BLOC $e ==================');
      }
    });
  }
}
