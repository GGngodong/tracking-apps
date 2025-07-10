import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking_apps/configs/network/http_response_model.dart';
import 'package:tracking_apps/configs/network/user/user_service.dart';
import 'package:tracking_apps/domain/entity/user_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserService userService;

  RegisterBloc({required this.userService}) : super(const RegisterState()) {
    on<RegisterButtonPressed>(_onRegisterPressed);
    on<ClearRegisterData>((_, emit) => emit(const RegisterState()));
  }

  Future<void> _onRegisterPressed(
    RegisterButtonPressed event,
    Emitter<RegisterState> emit,
  ) async {
    emit(const RegisterState(isLoading: true));
    try {
      final HttpResponseModel<dynamic> regRes = await userService.create(
        username: event.username,
        email: event.email,
        password: event.password,
        division: event.division,
      );
      if (regRes.data != null) {
        final HttpResponseModel<dynamic> loginRes = await userService.login(
          email: event.email,
          password: event.password,
        );

        if (loginRes.data != null) {
          final HttpResponseModel<dynamic> valRes = await userService.validate(
            token: loginRes.data!,
          );
          await userService.saveAuthTokenToSP(loginRes.data!);
          final user = UserModel.fromMap(valRes.data);
          emit(RegisterSuccess(
            user: user,
            message: 'Welcome, ${user.userName}!',
            isLoading: false,
          ));
        } else {
          emit(RegisterFailed(
            message: loginRes.message ?? 'Login failed',
            isLoading: false,
          ));
        }
      } else {
        emit(RegisterFailed(
          message: regRes.message ?? 'Registration failed',
          isLoading: false,
        ));
      }
    } catch (error) {
      emit(RegisterFailed(
        message: error.toString(),
        isLoading: false,
      ));
    }
  }
}
