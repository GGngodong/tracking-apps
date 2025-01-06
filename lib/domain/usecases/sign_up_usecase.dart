import 'package:dartz/dartz.dart';
import 'package:tracking_apps/common/service_locator.dart';
import 'package:tracking_apps/common/usecase.dart';
import 'package:tracking_apps/data/model/sign_up_request_parameters.dart';
import 'package:tracking_apps/domain/repository/auth_repository.dart';

class SignUpUseCase implements UseCase<Either, SignUpRequestParameters> {
  @override
  Future<Either> call({SignUpRequestParameters ? param}) async {
    try {
      return await sl<AuthRepository>().signUp(param!);
    } catch (e) {
      return Left('An error occured during sign-up');
    }
  }

}