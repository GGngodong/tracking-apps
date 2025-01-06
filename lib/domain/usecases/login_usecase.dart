import 'package:dartz/dartz.dart';
import 'package:tracking_apps/common/service_locator.dart';
import 'package:tracking_apps/common/usecase.dart';
import 'package:tracking_apps/data/model/login_request_parameters.dart';
import 'package:tracking_apps/domain/repository/auth_repository.dart';

class LoginUseCase implements UseCase<Either, LoginRequestParameters> {
  @override
  Future<Either> call({LoginRequestParameters? param}) async {
    try {
      return await sl<AuthRepository>().login(param!);
    } catch (e) {
      return Left('An error occured during login');
    }
  }
}
