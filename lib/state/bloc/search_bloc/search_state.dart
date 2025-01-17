part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchProductInitial extends SearchState {}

final class SearchProductLoadingState extends SearchState {}

final class SearchProductLoadedState extends SearchState {
  final SearchProductsResponse searchResponse;

  const SearchProductLoadedState({required this.searchResponse});
}

final class SearchProductErrorState extends SearchState {
  final String message;

  const SearchProductErrorState({required this.message});
}
