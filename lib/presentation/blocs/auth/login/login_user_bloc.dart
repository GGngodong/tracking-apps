import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_apps/data/model/login_request_parameters.dart';
import 'package:tracking_apps/domain/usecases/login_usecase.dart';

part 'login_user_event.dart';

part 'login_user_state.dart';

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  final LoginUseCase loginUseCase;

  LoginUserBloc({required this.loginUseCase}) : super(LoginUserInitial()) {
    on<LoginUserRequested>(_onLoginUserRequested);
  }

  Future<void> _onLoginUserRequested(
      LoginUserRequested event,
      Emitter<LoginUserState> emit,
      ) async {
    emit(LoginUserLoading());
    final result = await loginUseCase.call(
        param: LoginRequestParameters(
          email: event.email,
          password: event.password,
        ));
    result.fold(
            (failure) => emit(LoginUserFailure(failure)),
            (response) async {
          final token = response['data']['token'];
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('token', token);
          emit(LoginUserSuccess(response));
        }
    );
  }
}