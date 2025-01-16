part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoadingState extends CategoriesState {}

final class CategoriesLoadedState extends CategoriesState {
  final CategoriesResponseModel categoriesResponseModel;
  List<CategoryDatum> get categories =>
      categoriesResponseModel.categories?.categories?.data ?? [];
  final CategoryDatum? selectedCategory;
  final Subcategory? selectedSubCategory;

  const CategoriesLoadedState(
      {required this.categoriesResponseModel,
      this.selectedCategory,
      this.selectedSubCategory});

  @override
  List<Object> get props => [
        categoriesResponseModel,
      ];
}

final class CategoriesErrorState extends CategoriesState {
  final String message;

  const CategoriesErrorState({required this.message});
}
