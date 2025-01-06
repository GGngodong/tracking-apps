import 'package:dartz/dartz.dart';
import 'package:tracking_apps/common/failure.dart';
import 'package:tracking_apps/data/model/login_request_parameters.dart';
import 'package:tracking_apps/data/model/sign_up_request_parameters.dart';

abstract class AuthRepository {

  Future<Either> signUp(SignUpRequestParameters signUpRequestParameters);
  Future<Either> login(LoginRequestParameters loginRequestParameters);
  Future<Either> getAuthentication();

}