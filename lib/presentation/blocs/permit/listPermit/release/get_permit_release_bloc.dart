import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking_apps/configs/network/permit/permit_service.dart';
import 'package:tracking_apps/domain/entity/permit_model.dart';

part 'get_permit_release_event.dart';
part 'get_permit_release_state.dart';

class PermitLetterReleaseBloc
    extends Bloc<PermitLetterReleaseEvent, PermitLetterReleaseState> {
  final PermitService permitService;

  PermitLetterReleaseBloc({required this.permitService})
      : super(const PermitLetterReleaseState()) {
    on<GetListPermitLetter>((event, state) async {
      emit(const PermitLetterReleaseState(isLoading: true));
      try {
        final token = await permitService.getAuthTokenFromSP();
        if (token == null) {
          emit(PermitLetterFailedState(
              message: 'User is not authenticated. Please log in',
              isLoading: true,
              statusCode: 401));
          return;
        }
        final response = await permitService.getReleasePermit(authToken: token);
        if (response.statusCode == 200) {
          emit(PermitLetterLoadedState(
            listPermitLetter: response.data!.data,
            message: response.message,
            isLoading: false,
          ));
        } else {
          emit(PermitLetterFailedState(
            message: response.message ?? 'Failed to load permits',
            isLoading: false,
            statusCode: response.statusCode,
          ));
        }
      } catch (e) {
        emit(PermitLetterFailedState(
            message: e.toString(), isLoading: false, statusCode: 500));
      }
    });
  }
}
