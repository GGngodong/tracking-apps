import 'package:easy_localization/easy_localization.dart';
import 'package:tracking_apps/domain/entity/user_model.dart';

import 'http_response_model.dart';

abstract class UserInterface {
  Future<HttpResponseModel> login(
      {required String email, required String password});

  Future<HttpResponseModel> validate({required String token});

  Future<HttpResponseModel> create(
      {required String username,
      required String email,
      required String password});

  Future<HttpResponseModel> getById({required String id});

  Future<HttpResponseModel> update({required UserModel userModel});

  Future<HttpResponseModel> updatePassword(
      {required String userId, required String password});

  Future<HttpResponseModel> delete({required String id});

  Future<HttpResponseModel> check({required String email});

  //////////////////////////////////////// PERMIT MODULE ////////////////////////////////////////

  Future<HttpResponseModel> createPermit({
    required String description,
    required String noLetter,
    required String categoryPermit,
    required String companyName,
    required DateFormat date,
    required String productNoMabes,
    required String document,
  });
}
