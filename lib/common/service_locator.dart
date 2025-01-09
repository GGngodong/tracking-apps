import 'package:get_it/get_it.dart';
import 'package:tracking_apps/configs/network/dio_client.dart';
import 'package:tracking_apps/data/repository/auth_repository_impl.dart';
import 'package:tracking_apps/data/source/auth_api_service.dart';
import 'package:tracking_apps/domain/repository/auth_repository.dart';
import 'package:tracking_apps/domain/usecases/get_user_usecase.dart';
import 'package:tracking_apps/domain/usecases/login_usecase.dart';
import 'package:tracking_apps/domain/usecases/sign_up_usecase.dart';
import 'package:tracking_apps/presentation/blocs/auth/login/login_user_bloc.dart';

import '../presentation/blocs/auth/get_user/get_user_bloc.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());

  sl.registerLazySingleton(() => LoginUseCase());

  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  sl.registerFactory(() => GetUserBloc(getUserUseCase: sl<GetUserUseCase>()));

  sl.registerFactory(() => LoginUserBloc(loginUseCase: sl<LoginUseCase>()));
}
