import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/network/http_response_model.dart';
import 'package:tracking_apps/configs/network/user_service.dart';
import 'package:tracking_apps/domain/entity/user_model.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserService userService;

  LoginBloc({required this.userService}) : super(const LoginState()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(const LoginState(isLoading: true));
      try {
        HttpResponseModel<dynamic> loginResponse = await userService.login(
            email: event.email, password: event.password);
        if (loginResponse.data != null) {
          HttpResponseModel<dynamic> validateResponse =
              await userService.validate(token: loginResponse.data);

          if (validateResponse.data != null) {
            await userService.saveAuthTokenToSP(loginResponse.data);
            await SharedPreferencesService.instance.setData<String>(PreferenceKey.userRole, loginResponse.data);
            final user = UserModel.fromMap(validateResponse.data);
            emit(LoginSuccess(
                user: user,
                message: validateResponse.message,
                isLoading: false));
            print(
                '================== IN LOGIN SUCCESS BLOC ==================');
          } else {
            emit(LoginFailed(
                message: validateResponse.message,
                isLoading: false,
                statusCode: validateResponse.statusCode));
            print(
                '================== IN LOGIN FAILED BLOC 1 ==================');
          }
        } else {
          emit(LoginFailed(
              isLoading: false,
              message: loginResponse.message,
              statusCode: loginResponse.statusCode));
          print('================== IN LOGIN FAILED BLOC 2 ==================');
        }
      } catch (error) {
        emit(LoginFailed(
            message: error.toString(), isLoading: false, statusCode: 404));
        print('================== IN LOGIN ERROR BLOC ==================');
      }
    });

    on<ValidateAuthToken>((event, emit) async {
      emit(const LoginState(isLoading: true));
      try {
        HttpResponseModel<dynamic> validateResponse =
            await userService.validate(token: event.authToken);
        if (validateResponse.statusCode == 200) {
          final user = UserModel.fromMap(validateResponse.data);
          emit(
            ValidateSuccess(
                user: user,
                statusCode: validateResponse.statusCode,
                message: validateResponse.message,
                isLoading: false),
          );
        } else {
          emit(
            ValidateFailed(
              message: validateResponse.message,
              statusCode: validateResponse.statusCode,
              isLoading: false,
            ),
          );
        }
      } catch (error) {
        await userService.deleteAuthTokenFromSP();
        emit(ValidateFailed(message: error.toString(), isLoading: false));
      }
    });

    on<LogoutButtonPressed>((event, emit) async {
      await userService.deleteAuthTokenFromSP();
      emit(const LoginState(isLoading: false));
    });


    on<ClearLoginData>((event, emit) async {
      emit(const LoginState());
    });
  }
}
