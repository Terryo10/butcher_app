part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoadingState extends CategoriesState {}

final class CategoriesLoadedState extends CategoriesState {
  final CategoriesResponse categoriesResponseModel;
  //  List<CategoryDatum> get categories => categoriesResponseModel?.categories?.categories?.data ?? [];

  const CategoriesLoadedState({
    required this.categoriesResponseModel,
  });
}

final class SubCategoriesLoadedState extends CategoriesState {
  final Datum selectedSubCategories;

  const SubCategoriesLoadedState({
    required this.selectedSubCategories,
  });
}

final class ProductsLoadedState extends CategoriesState {
  final Subcategory selectedProducts;

  const ProductsLoadedState({
    required this.selectedProducts,
  });
}

final class CategoriesErrorState extends CategoriesState {
  final String message;

  const CategoriesErrorState({required this.message});
}
