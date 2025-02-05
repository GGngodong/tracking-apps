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

  const SearchPermitLetter(
      this.searchQuery,
      this.searchParam, {
        required this.categoryPermitSearchQuery,
        required this.categoryPermitSearchParam,
      });

  @override
  List<Object?> get props => [
        searchQuery,
        searchParam,
        categoryPermitSearchQuery,
        categoryPermitSearchParam,
      ];
}

class GetPermitLetterSearch extends SearchEvent {}
