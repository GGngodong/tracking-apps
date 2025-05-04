import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking_apps/configs/network/http_response_model.dart';
import 'package:tracking_apps/configs/network/user_service.dart';
import 'package:tracking_apps/domain/entity/permit_model.dart';

part 'upload_event.dart';

part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final UserService userService;

  UploadBloc({required this.userService}) : super(const UploadState()) {
    on<UploadButtonPressed>((event, emit) async {
      emit(const UploadState(isLoading: true));
      try {
        final token = await userService.getAuthTokenFromSP();
        if (token == null) {
          emit(UploadFailed(
            message: 'User is not authenticated. Please log in.',
            isLoading: false,
            statusCode: 401,
          ));
          return;
        }
        if (event.documentUrl == null || event.documentUrl!.isEmpty) {
          emit(UploadFailed(
            message: 'Document URL is required.',
            isLoading: false,
            statusCode: 400,
          ));
          return;
        }
        HttpResponseModel<dynamic> uploadResponse =
            await userService.createPermit(
          description: event.description,
          noPermit: event.noPermit,
          categoryPermit: event.categoryPermit,
          companyName: event.companyName,
          date: event.date,
          noPermitMabes: event.noPermitMabes,
          processStatus: 'Draft Created',
          documentUrl: event.documentUrl,
              categoryAdministration : event.categoryAdministration,
          authToken: token,
        );
        if (uploadResponse.statusCode == 200 ||
            uploadResponse.statusCode == 201) {
          final permit = uploadResponse.data as PermitModel;
          emit(UploadSuccess(
              permit: permit,
              message: uploadResponse.message,
              isLoading: false));
          print('================== IN UPLOAD SUCCESS BLOC ==================');
        } else {
          emit(UploadFailed(
              message: uploadResponse.message,
              isLoading: false,
              statusCode: uploadResponse.statusCode));
          print('================== IN UPLOAD FAILED BLOC ==================');
        }
      } catch (error) {
        emit(UploadFailed(
            message: error.toString(), isLoading: false, statusCode: 500));
        print('================== IN UPLOAD ERROR BLOC ==================');
      }
    });



  }
}
