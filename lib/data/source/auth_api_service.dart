import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tracking_apps/common/base_url.dart';
import 'package:tracking_apps/common/service_locator.dart';
import 'package:tracking_apps/configs/network/dio_client.dart';
import 'package:tracking_apps/data/model/login_request_parameters.dart';
import 'package:tracking_apps/data/model/sign_up_request_parameters.dart';

abstract class AuthApiService {
  Future<Either> signUp(SignUpRequestParameters signUpRequestParameters);

  Future<Either> login(LoginRequestParameters loginRequestParameters);

}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signUp(SignUpRequestParameters signUpRequestParameters) async {
    try {
      var response = await sl<DioClient>()
          .post(BaseUrl.register, data: signUpRequestParameters.toMap());
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> login(LoginRequestParameters loginRequestParameters) async {
    try {
      var response = await sl<DioClient>()
          .post(BaseUrl.login, data: loginRequestParameters.toMap());
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> getUser(String token) async {
    try {
      var response = await sl<DioClient>().get(
        BaseUrl.getUser,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

}
