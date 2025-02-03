import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking_apps/configs/network/http_response_model.dart';
import 'package:tracking_apps/configs/network/user_service.dart';
import 'package:tracking_apps/domain/entity/permit_model.dart';

part 'edit_event.dart';

part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  final UserService userService;

  EditBloc({required this.userService}) : super(const EditState()) {
    on<UpdateDataButtonPressed>((event, emit) async {
      emit(const EditState(isLoading: true));
      try {
        final token = await userService.getAuthTokenFromSP();
        if (token == null) {
          emit(EditFailedState(
            message: 'User is not authenticated. Please log in.',
            isLoading: false,
            statusCode: 401,
          ));
          print('================== AUTH TOKEN IS NULL! ==================');
          return;
        }

        print('================== SENDING API REQUEST ==================');
        print('ID: ${event.id}, Status Tahapan: ${event.processStatus}');
        HttpResponseModel<dynamic> updateResponse =
            await userService.updatePermit(
          id: event.id,
          processStatus: event.processStatus,
          authToken: token,
        );
        if (updateResponse.statusCode == 200) {
          final permit =
          updateResponse.data as PermitModel;
          emit(EditSuccessState(
              permit: permit,
              message: updateResponse.message,
              isLoading: false));
          print('================== IN EDIT SUCCESS BLOC ==================');
        } else {
          emit(EditFailedState(
              message: updateResponse.message,
              isLoading: false,
              statusCode: updateResponse.statusCode));
        }
      } catch (e) {
        emit(EditFailedState(
            message: e.toString(), isLoading: false, statusCode: 500));
        print('================== IN EDIT FAILED BLOC ==================');
      }
    });

    on<DeleteDataButtonPressed>((event, emit) async {
      emit(const EditState(isLoading: true));
      try {
        final token = await userService.getAuthTokenFromSP();
        if (token == null) {
          emit(EditFailedState(
            message: 'User is not authenticated. Please log in.',
            isLoading: false,
            statusCode: 401,
          ));
          print('================== AUTH TOKEN IS NULL! ==================');
          return;
        }

        print('================== SENDING DELETE REQUEST ==================');
        print('Deleting Permit with ID: ${event.id}');

        HttpResponseModel<dynamic> deleteResponse =
        await userService.deletePermit(id: event.id, authToken: token);

        print('================== DELETE RESPONSE RECEIVED ==================');
        print('Status Code: ${deleteResponse.statusCode}');
        print('Message: ${deleteResponse.message}');

        if (deleteResponse.statusCode == 200) {
          emit(DeleteSuccessState(
            message: deleteResponse.message,
            isLoading: false,
          ));
          print('================== PERMIT SUCCESSFULLY DELETED ==================');
        } else {
          emit(EditFailedState(
            message: deleteResponse.message,
            isLoading: false,
            statusCode: deleteResponse.statusCode,
          ));
        }
      } catch (e) {
        emit(EditFailedState(
          message: 'An error occurred: $e',
          isLoading: false,
          statusCode: 500,
        ));
        print('================== DELETE FAILED ==================');
        print(e.toString());
      }
    });

  }
}
