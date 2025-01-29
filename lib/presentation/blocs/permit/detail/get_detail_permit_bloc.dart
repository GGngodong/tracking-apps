import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking_apps/configs/network/user_service.dart';
import 'package:tracking_apps/domain/entity/permit_model.dart';

part 'get_detail_permit_event.dart';

part 'get_detail_permit_state.dart';

class DetailPermitLetterBloc
    extends Bloc<DetailPermitLetterEvent, DetailPermitLetterState> {
  final UserService userService;

  DetailPermitLetterBloc({required this.userService})
      : super(const DetailPermitLetterState()) {
    on<GetDetailPermitLetterEvent>(
      (event, state) async {
        emit(const DetailPermitLetterState(isLoading: true));
        try {
          final token = await userService.getAuthTokenFromSP();
          if (token == null) {
            emit(DetailPermitLetterFailedState(
                message: 'User is not authenticated. Please log in',
                isLoading: true,
                statusCode: 401));
            return;
          }
          final response =
              await userService.getDetailPermit(authToken: token, id: event.id);
          if (response.statusCode == 200 && response.data != null) {
            emit(
              DetailPermitLetterLoadedState(
                permit: response.data!,
                message: response.message,
                isLoading: false,
              ),
            );
            print('================== GET DETAIL SUCCESS ==================');
            print('Permit Details: ${response.data?.toJson()}');
          } else {
            emit(DetailPermitLetterFailedState(
              message: response.message ?? 'Failed to load permits',
              isLoading: false,
              statusCode: response.statusCode,
            ));
            print('================== GET DETAIL SUCCESS ==================');
          }
        } catch (e) {
          emit(DetailPermitLetterFailedState(
              message: e.toString(), isLoading: false, statusCode: 500));
          print(
              '================== IN GET PERMIT FAILED BLOC ==================');
        }
      },
    );
  }
}
