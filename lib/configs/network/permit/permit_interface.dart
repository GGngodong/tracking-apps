import 'package:tracking_apps/configs/network/http_response_model.dart';

abstract class PermitInterface {
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
    String? documentUrl,
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

  Future<HttpResponseModel> getReleasePermit({
    required String authToken,
  });
}
