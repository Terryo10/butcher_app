import 'package:bloc/bloc.dart';
import 'package:butcher_app/repositories/products_repository/products_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../models/categories/categories_response_model_test.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final ProductsRepository productsRepository;

  CategoriesBloc({required this.productsRepository})
      : super(const CategoriesInitial()) {
    on<GetCategories>((event, emit) async {
      // Retain current state data while loading categories
      emit(CategoriesLoadingState(
        categoriesResponseModel: state.categoriesResponseModel,
        selectedSubCategories: state.selectedSubCategories,
        selectedProducts: state.selectedProducts,
      ));

      try {
        final categories = await productsRepository.getCategories();
        emit(CategoriesLoadedState(
          categoriesResponseModel: categories,
          selectedSubCategories: state.selectedSubCategories,
          selectedProducts: state.selectedProducts,
        ));
      } catch (e) {
        emit(CategoriesErrorState(
          message: e.toString(),
          categoriesResponseModel: state.categoriesResponseModel,
          selectedSubCategories: state.selectedSubCategories,
          selectedProducts: state.selectedProducts,
        ));
      }
    });

    on<GetSelectedSubCategory>((event, emit) {
      // Update selected subcategories while retaining other data
      emit(CategoriesLoadedState(
        selectedSubCategories: event.selectedSubCategories,
        categoriesResponseModel: state.categoriesResponseModel,
        selectedProducts: state.selectedProducts,
      ));
    });

    on<GetSelectedProducts>((event, emit) {
      // Update selected products while retaining other data
      emit(CategoriesLoadedState(
        selectedProducts: event.selectedProducts,
        categoriesResponseModel: state.categoriesResponseModel,
        selectedSubCategories: state.selectedSubCategories,
      ));
    });
  }
}
