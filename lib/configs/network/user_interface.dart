import 'package:tracking_apps/domain/entity/user_model.dart';

import 'http_response_model.dart';

abstract class UserInterface {
  Future<HttpResponseModel> login(
      {required String email, required String password});

  Future<HttpResponseModel> validate({required String token});

  Future<HttpResponseModel> update({required UserModel userModel});

  Future<HttpResponseModel> create(
      {required String username,
      required String email,
      required String password});

  Future<HttpResponseModel> delete({required String id});

  //////////////////////////////////////// PERMIT MODULE ////////////////////////////////////////

  Future<HttpResponseModel> createPermit({
    required String description,
    required String noPermit,
    required String categoryPermit,
    required String companyName,
    required String date,
    required String authToken,
    String? noPermitMabes,
    required String documentUrl,
  });

  Future<HttpResponseModel> updatePermit({
    required String description,
    required String noPermit,
    required String categoryPermit,
    required String companyName,
    required String noPermitMabes,
  });

  Future<HttpResponseModel> getListPermit({
    required String authToken,
  });

  Future<HttpResponseModel> getDetailPermit({
    required String id, required String authToken,
  });
}
