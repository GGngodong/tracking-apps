import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:tracking_apps/domain/usecases/get_user_usecase.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  final GetUserUseCase getUserUseCase;

  GetUserBloc({required this.getUserUseCase}) : super(GetUserInitial()) {
    on<GetUserRequested>(_onGetUserRequested);
  }

  Future<void> _onGetUserRequested(
      GetUserRequested event,
      Emitter<GetUserState> emit,
      ) async {
    emit(GetUserLoading());
    final result = await getUserUseCase.call(param: NoParams());
    result.fold(
          (failure) => emit(GetUserFailure(failure)),
          (user) => emit(GetUserSuccess(user)),
    );
  }
}