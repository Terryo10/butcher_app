part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
  
  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoadingState extends CategoriesState {}

final class CategoriesLoadedState extends CategoriesState {
}

final class CategoriesError extends CategoriesState {}