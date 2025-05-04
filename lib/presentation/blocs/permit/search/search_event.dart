part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchPermitLetter extends SearchEvent {
  final String? searchQuery;
  final String? searchParam;
  final String? categoryPermitSearchQuery;
  final String? categoryPermitSearchParam;
  final String? subCategoryPermitSearchQuery;
  final String? subCategoryPermitSearchParam;

  const SearchPermitLetter(this.searchQuery, this.searchParam,
      {required this.categoryPermitSearchQuery,
      required this.categoryPermitSearchParam,
      required this.subCategoryPermitSearchQuery,
      required this.subCategoryPermitSearchParam});

  @override
  List<Object?> get props => [
        searchQuery,
        searchParam,
        categoryPermitSearchQuery,
        categoryPermitSearchParam,
        subCategoryPermitSearchQuery,
        subCategoryPermitSearchParam
      ];
}

class GetPermitLetterSearch extends SearchEvent {}
