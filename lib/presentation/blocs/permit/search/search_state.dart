part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String? message;
  final bool isLoading;
  final int? statusCode;

  const SearchState({
    this.message,
    this.isLoading = false,
    this.statusCode,
  });

  @override
  List<Object?> get props => [];
}

class SearchLoadingState extends SearchState {}

class SearchFailedState extends SearchState {
  const SearchFailedState({
    super.statusCode,
    super.message,
    super.isLoading,
  });

  @override
  List<Object?> get props => [statusCode, message, isLoading];
}

class SearchLoadedState extends SearchState {
  final List<PermitModel> listPermitLetter;

  const SearchLoadedState({
    required this.listPermitLetter,
    super.statusCode,
    super.message,
    super.isLoading,
  });

  @override
  List<Object?> get props => [listPermitLetter, statusCode, message, isLoading];
}

class SearchEmptyState extends SearchState {
  const SearchEmptyState({
    super.statusCode,
    super.message,
    super.isLoading,
  });

  @override
  List<Object?> get props => [statusCode, message, isLoading];
}

class SearchNotFoundState extends SearchState {
  const SearchNotFoundState({
    super.statusCode,
    super.message,
    super.isLoading,
  });

  @override
  List<Object?> get props => [statusCode, message, isLoading];
}
