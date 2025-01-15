part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  final CategoriesResponse? categoriesResponseModel;
  final List<Subcategory>? selectedSubCategories;
  final Subcategory? selectedProducts;

  const CategoriesState({
    this.categoriesResponseModel,
    this.selectedSubCategories,
    this.selectedProducts,
  });

  @override
  List<Object?> get props => [
        categoriesResponseModel,
        selectedSubCategories,
        selectedProducts,
      ];
}

final class CategoriesInitial extends CategoriesState {
  const CategoriesInitial()
      : super(
          categoriesResponseModel: null,
          selectedSubCategories: null,
          selectedProducts: null,
        );
}

final class CategoriesLoadingState extends CategoriesState {
  const CategoriesLoadingState({
    super.categoriesResponseModel,
    super.selectedSubCategories,
    super.selectedProducts,
  });
}

final class CategoriesLoadedState extends CategoriesState {
  const CategoriesLoadedState({
    required CategoriesResponse? super.categoriesResponseModel,
    super.selectedSubCategories,
    super.selectedProducts,
  });
}

final class SubCategoriesLoadedState extends CategoriesState {
  const SubCategoriesLoadedState({
    required List<Subcategory> super.selectedSubCategories,
    super.categoriesResponseModel,
    super.selectedProducts,
  });
}

final class ProductsLoadedState extends CategoriesState {
  const ProductsLoadedState({
    required Subcategory super.selectedProducts,
    super.categoriesResponseModel,
    super.selectedSubCategories,
  });
}

final class CategoriesErrorState extends CategoriesState {
  final String message;

  const CategoriesErrorState({
    required this.message,
    super.categoriesResponseModel,
    super.selectedSubCategories,
    super.selectedProducts,
  });

  @override
  List<Object?> get props => super.props..add(message);
}
