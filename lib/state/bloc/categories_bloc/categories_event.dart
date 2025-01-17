part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetCategories extends CategoriesEvent {}

class SelectCategory extends CategoriesEvent {
  final dynamic categoriesLoadedState;
  final CategoryDatum categoryItem;

  const SelectCategory({
    required this.categoriesLoadedState,
    required this.categoryItem,
  });
}

class SelectCategoryFromStart extends CategoriesEvent {
  final dynamic categoriesLoadedState;
  final CategoryDatum categoryItem;

  const SelectCategoryFromStart({
    required this.categoriesLoadedState,
    required this.categoryItem,
  });
}

class SelectSubCategory extends CategoriesEvent {
  final dynamic categoriesLoadedState;
  final CategoryDatum categoryItem;
  final Subcategory subcategory;

  const SelectSubCategory({
    required this.categoriesLoadedState,
    required this.categoryItem,
    required this.subcategory,
  });
}

class SelectSubCategoryFromStart extends CategoriesEvent {
  final dynamic categoriesLoadedState;
  final CategoryDatum categoryItem;
  final Subcategory subcategory;

  const SelectSubCategoryFromStart({
    required this.categoriesLoadedState,
    required this.categoryItem,
    required this.subcategory,
  });
}
