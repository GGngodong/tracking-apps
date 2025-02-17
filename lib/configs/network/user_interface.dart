import 'package:tracking_apps/domain/entity/user_model.dart';

import 'http_response_model.dart';

abstract class UserInterface {
  Future<HttpResponseModel> login(
      {required String email, required String password});

  Future<HttpResponseModel> validate({required String token});

  Future<HttpResponseModel> update({required UserModel userModel});

  Future<HttpResponseModel> create({
    required String username,
    required String email,
    required String password,
  });

  Future<HttpResponseModel> delete({required String id});

  //////////////////////////////////////// PERMIT MODULE ////////////////////////////////////////

  Future<HttpResponseModel> createPermit({
    required String description,
    required String noPermit,
    required String categoryPermit,
    required String companyName,
    required String date,
    required String authToken,
    required String documentUrl,
    required String categoryAdministration,
    String? noPermitMabes,
    String? processStatus,
    String uploadStatus,
  });

  Future<HttpResponseModel> updatePermit({
    required String id,
    required String authToken,
    String? processStatus,
    String? uploadStatus,
    String? noProdukMabes,
    String? note,
  });

  Future<HttpResponseModel> getListPermit({
    required String authToken,
  });

  Future<HttpResponseModel> getDetailPermit({
    required String id,
    required String authToken,
  });

  Future<HttpResponseModel> deletePermit({
    required String id,
    required String authToken,
  });

  Future<HttpResponseModel> searchPermit({
    required String authToken,
    String? searchQuery,
    String? searchParam,
    String? categoryPermitSearchParam,
    String? categoryPermitSearchQuery,
    String? subCategoryPermitSearchParam,
    String? subCategoryPermitSearchQuery,
  });

  Future<HttpResponseModel> getLatestPermit({
    required String authToken,
  });

  Future<HttpResponseModel> getApprovedPermit({
    required String authToken,
  });

  Future<HttpResponseModel> getRejectedPermit({
    required String authToken,
  });

  Future<HttpResponseModel> getPendingPermit({
    required String authToken,
  });

  Future<HttpResponseModel> updateDeviceToken({
    required String authToken,
    required String deviceToken,
  });
}
