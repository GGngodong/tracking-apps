import 'package:dartz/dartz.dart';
import 'package:tracking_apps/common/service_locator.dart';
import 'package:tracking_apps/common/usecase.dart';
import 'package:tracking_apps/domain/repository/auth_repository.dart';

class GetUserUseCase implements UseCase<Either, NoParams> {
  @override
  Future<Either> call ({NoParams? param}) async {
    try {
      return await sl<AuthRepository>().getAuthentication();
    } catch (e) {
      return Left('An error occured while fetching the user');
    }
  }
}

class NoParams {}