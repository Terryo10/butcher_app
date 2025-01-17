part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchProduct extends SearchEvent {
  final String name;

  const SearchProduct({required this.name});
}
