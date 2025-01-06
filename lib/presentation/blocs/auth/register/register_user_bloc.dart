import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking_apps/data/model/sign_up_request_parameters.dart';
import 'package:tracking_apps/domain/usecases/sign_up_usecase.dart';

part 'register_user_event.dart';

part 'register_user_state.dart';

class RegisterUserBloc extends Bloc<RegisterUserEvent, RegisterUserState> {
  final SignUpUseCase signUpUseCase;

  RegisterUserBloc({required this.signUpUseCase})
      : super(RegisterUserInitial()) {
    on<RegisterUserRequested>(_onRegisterUserRequested);
  }

  Future<void> _onRegisterUserRequested(
    RegisterUserRequested event,
    Emitter<RegisterUserState> emit,
  ) async {
    emit(RegisterUserLoading());
    final result = await signUpUseCase.call(
      param: SignUpRequestParameters(
        username: event.username,
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(RegisterUserFailure(failure)),
      (response) => emit(RegisterUserSuccess(response)),
    );
  }
}
