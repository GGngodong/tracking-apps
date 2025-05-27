import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
            await SharedPreferencesService.instance
                .setData<String>(PreferenceKey.userRole, loginResponse.data);
            final user = UserModel.fromMap(validateResponse.data);

            String? deviceToken = await FirebaseMessaging.instance.getToken();
            if (deviceToken != null) {
              await userService.updateDeviceToken(
                authToken: loginResponse.data,
                deviceToken: deviceToken,
              );
            }
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
      emit(const LoginState(isLoading: false));
      try {
        final token = await userService.getAuthTokenFromSP();
        if (token == null) {
          emit(const LoginState(
              message: 'User is not authenticated. Please log in.',
              isLoading: false,
              statusCode: 401));
          print('================== AUTH TOKEN IS NULL! ==================');
          return;
        }

        print('================== SENDING LOGOUT REQUEST ==================');
        print('User Logout with Token : ${event.authToken}');

        HttpResponseModel<dynamic> logoutResponse =
            await userService.delete(authToken: event.authToken);
        print('Logout Response : ${logoutResponse.message}');

        if (logoutResponse.statusCode == 200) {
          await userService.deleteAuthTokenFromSP();
          emit(LogoutSuccess(
            message: logoutResponse.message,
            isLoading: false,
            statusCode: logoutResponse.statusCode,
          ));
          print('================== IN LOGOUT SUCCESS BLOC ==================');
        } else {
          emit(LogoutFailed(
            message: logoutResponse.message,
            isLoading: false,
            statusCode: logoutResponse.statusCode,
          ));
        }
      } catch (e) {
        emit(LogoutFailed(
            message: e.toString(), isLoading: false, statusCode: 500));
        print('================== IN LOGOUT FAILED BLOC ==================');
      }
    });

    on<ClearLoginData>((event, emit) async {
      emit(const LoginState());
    });
  }
}
