import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_apps/common/service_locator.dart';
import 'package:tracking_apps/data/model/login_request_parameters.dart';
import 'package:tracking_apps/data/model/sign_up_request_parameters.dart';
import 'package:tracking_apps/data/source/auth_api_service.dart';
import 'package:tracking_apps/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signUp(SignUpRequestParameters signUpRequestParameters) {
    return sl<AuthApiService>().signUp(signUpRequestParameters);
  }

  @override
  Future<Either> login(LoginRequestParameters loginRequestParameters) {
  return sl<AuthApiService>().login(loginRequestParameters);
  }

  @override
  Future<Either> getAuthentication() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString('token');

      if(token != null) {
        final response = await sl<AuthApiService>().getUser(token);
        return Right(response);
      }
      return Left('Token not found');
    } catch (e) {
      return Left('Failed to fetch user: $e');
    }
  }

}