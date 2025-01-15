import 'package:bloc/bloc.dart';
import 'package:butcher_app/repositories/products_repository/products_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../models/categories/categories_response_model_test.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final ProductsRepository productsRepository;
  CategoriesBloc({required this.productsRepository})
      : super(CategoriesInitial()) {
    on<GetCategories>(
      (event, emit) async {
        emit(CategoriesLoadingState());
        try {
          emit(
            CategoriesLoadedState(
              categoriesResponseModel: await productsRepository.getCategories(),
            ),
          );
        } catch (e) {
          emit(
            CategoriesErrorState(
              message: e.toString(),
            ),
          );
        }
      },
    );
    on<GetSelectedSubCategory>(
      (event, emit) async {
        try {
          emit(
            SubCategoriesLoadedState(
              selectedSubCategories: event.selectedSubCategories,
            ),
          );
        } catch (e) {
          emit(
            CategoriesErrorState(
              message: e.toString(),
            ),
          );
        }
      },
    );
    on<GetSelectedProducts>(
      (event, emit) async {
        try {
          emit(
            ProductsLoadedState(
              selectedProducts: event.selectedProducts,
            ),
          );
        } catch (e) {
          emit(
            CategoriesErrorState(
              message: e.toString(),
            ),
          );
        }
      },
    );
  }
}
