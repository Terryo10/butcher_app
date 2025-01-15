part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetCategories extends CategoriesEvent {}

class GetSelectedSubCategory extends CategoriesEvent {
  final List<Subcategory>? selectedSubCategories;

  const GetSelectedSubCategory({required this.selectedSubCategories});
}

class GetSelectedProducts extends CategoriesEvent {
  final Subcategory selectedProducts;

  const GetSelectedProducts({required this.selectedProducts});
}
