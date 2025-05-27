import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking_apps/configs/network/user_service.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final UserService userService;

  ResetPasswordBloc({required this.userService})
      : super(const ResetPasswordState()) {
    on<ResetPasswordButtonPressed>((event, emit) async {
      emit(const ResetPasswordState(isLoading: true));
      try {
        final response = await userService.resetPassword(email: event.email);

        if (response.statusCode == 200 && response.status == "success") {
          emit(ResetPasswordSuccess(
            email: event.email,
            message: response.message,
            isLoading: false,
          ));
        } else {
          emit(ResetPasswordFailed(
            message: response.message ?? 'Unknown error',
            isLoading: false,
          ));
        }
      } catch (error) {
        emit(ResetPasswordFailed(
          message: error.toString(),
          isLoading: false,
        ));
      }
    });
  }
}
