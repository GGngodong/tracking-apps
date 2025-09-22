import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracking_apps/configs/network/permit/permit_service.dart';
import 'package:tracking_apps/domain/entity/permit_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final PermitService permitService;

  SearchBloc({required this.permitService}) : super(const SearchState()) {
    on<SearchPermitLetter>((event, state) async {
      emit(const SearchState(isLoading: true));
      try {
        final token = await permitService.getAuthTokenFromSP();
        if (token == null) {
          emit(SearchFailedState(
              message: 'User is not authenticated. Please log in',
              isLoading: true,
              statusCode: 401));
          return;
        }
        final response = await permitService.searchPermit(
            authToken: token,
            searchQuery: event.searchQuery,
            searchParam: event.searchParam,
            categoryPermitSearchQuery: event.categoryPermitSearchQuery,
            categoryPermitSearchParam: event.categoryPermitSearchParam,
            subCategoryPermitSearchQuery: event.subCategoryPermitSearchQuery,
            subCategoryPermitSearchParam: event.subCategoryPermitSearchParam);
        if (response.statusCode == 200) {
          emit(SearchLoadedState(
            listPermitLetter: response.data!.data,
            message: response.message,
            isLoading: false,
          ));
          print('================== SEARCH PERMIT SUCCESS ==================');
        } else if (response.statusCode == 404) {
          emit(SearchEmptyState(
            message: response.message,
            isLoading: false,
            statusCode: response.statusCode,
          ));
          print('================== SEARCH PERMIT EMPTY ==================');
        } else {
          emit(SearchFailedState(
            message: response.message ?? 'Failed to search permits',
            isLoading: false,
            statusCode: response.statusCode,
          ));
          print('================== SEARCH PERMIT FAILED ==================');
        }
      } catch (e) {
        emit(SearchFailedState(
            message: e.toString(), isLoading: false, statusCode: 500));
        print(
            '================== IN SEARCH PERMIT FAILED BLOC ${e.toString()} ==================');
      }
    });
  }
}
