import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tracking_apps/configs/network/firebase_service.dart';
import 'package:tracking_apps/configs/network/http_response_model.dart';
import 'package:tracking_apps/configs/network/user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking_apps/domain/entity/user_model.dart';
import 'package:tracking_apps/generated/locale_keys.g.dart';

part 'register_event.dart';
part 'register_state.dart';
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserService userService;

  RegisterBloc({required this.userService}) : super(const RegisterState()) {
    on<RegisterButtonPressed>((event, emit) async {
      emit(const RegisterState(isLoading: true));
      try {
        HttpResponseModel<dynamic> registerResponse = await userService.create(
            username: event.username,
            email: event.email,
            password: event.password);
        if (registerResponse.data != null) {
          HttpResponseModel<dynamic> loginResponse = await userService.login(
              email: event.email, password: event.password);
          if (loginResponse.data != null) {
            HttpResponseModel<dynamic> validateResponse =
                await userService.validate(token: loginResponse.data);
            await userService.saveAuthTokenToSP(loginResponse.data);
            final user = UserModel.fromMap(validateResponse.data);
            emit(RegisterSuccess(
                user: user,
                message: validateResponse.message,
                isLoading: false));
            print('================== IN REGISTER SUCCESS BLOC ==================');
          } else {
            emit(RegisterState(
                isLoading: false, message: loginResponse.message));
            print('================== IN REGISTER STATE BLOC ==================');
          }
        } else {
          emit(RegisterState(
              isLoading: false, message: registerResponse.message));
        }
      } catch (error) {
        emit(RegisterFailed(message: error.toString(), isLoading: false));
        print('================== IN REGISTER FAILED BLOC ==================');
      }
    });

    on<CheckButtonPressed>((event, emit) async {
      emit(const RegisterState(isLoading: true));
      try {
        HttpResponseModel<dynamic> checkResponse =
            await userService.check(email: event.email);
        if (checkResponse.data != null) {
          if (!checkResponse.data) {
            int? verificationCode =
                await FirebaseService.sendVerificationCode(toMail: event.email);
            emit(
              CheckSuccess(
                username: event.username,
                email: event.email,
                password: event.password,
                verificationCode: verificationCode,
                isLoading: false,
                message: checkResponse.message,
                data: checkResponse.data,
              ),
            );
          } else {
            emit(
              CheckSuccess(
                username: event.username,
                email: event.email,
                password: event.password,
                isLoading: false,
                data: checkResponse.data,
                message: checkResponse.message,
              ),
            );
          }
        }
      } catch (error) {
        emit(CheckFailed(
            message: error.toString(), isLoading: false, data: null));
      }
    });


    on<ClearRegisterData>((event, emit) async {
      emit(const RegisterState());
    });
  }
}
