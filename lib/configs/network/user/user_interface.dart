import 'package:tracking_apps/configs/network/http_response_model.dart';
import 'package:tracking_apps/domain/entity/user_model.dart';

abstract class UserInterface {
  Future<HttpResponseModel> login(
      {required String email, required String password});

  Future<HttpResponseModel> validate({required String token});

  Future<HttpResponseModel> update({required UserModel userModel});

  Future<HttpResponseModel> create({
    required String username,
    required String email,
    required String password,
    required String division,
  });

  Future<HttpResponseModel> delete({
    required String authToken,
  });

  Future<HttpResponseModel> resetPassword({
    required String email,
  });

  Future<HttpResponseModel> updateDeviceToken({
    required String authToken,
    required String deviceToken,
  });
}
