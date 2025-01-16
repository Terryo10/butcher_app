import 'package:bloc/bloc.dart';
import 'package:butcher_app/repositories/products_repository/products_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../models/categories/categories_response_model.dart';
import '../../../models/categories/category_datum.dart';
import '../../../models/categories/subcategory.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final ProductsRepository productsRepository;
  CategoriesBloc({required this.productsRepository})
      : super(CategoriesInitial()) {
    on<GetCategories>(
      (event, emit) async {
        emit(CategoriesLoadingState());
        var response = await productsRepository.getCategories();
        try {
          emit(
            CategoriesLoadedState(
              categoriesResponseModel: response,
            ),
          );
          if (response.categories?.categories?.data?.isNotEmpty ?? false) {
            add(SelectCategoryFromStart(
              categoriesLoadedState: response,
              categoryItem: response.categories?.categories?.data?.first ??
                  CategoryDatum(),
            ));
          }
        } catch (e) {
          emit(
            CategoriesErrorState(
              message: e.toString(),
            ),
          );
        }
      },
    );

    on<SelectCategoryFromStart>((event, emit) async {
      emit(CategoriesLoadingState());
      try {
        emit(
          CategoriesLoadedState(
              categoriesResponseModel: event.categoriesLoadedState,
              selectedCategory: event.categoryItem),
        );
        if (event.categoryItem.subcategories?.isNotEmpty ?? false) {
          add(SelectSubCategoryFromStart(
              categoriesLoadedState: event.categoriesLoadedState,
              categoryItem: event.categoryItem ?? CategoryDatum(),
              subcategory:
                  event.categoryItem.subcategories?.first ?? Subcategory()));
        }
      } catch (e) {
        emit(
          CategoriesErrorState(
            message: e.toString(),
          ),
        );
      }
    });
    on<SelectCategory>((event, emit) async {
      emit(CategoriesLoadingState());
      try {
        emit(
          CategoriesLoadedState(
              categoriesResponseModel:
                  event.categoriesLoadedState.categoriesResponseModel,
              selectedCategory: event.categoryItem),
        );
      } catch (e) {
        emit(
          CategoriesErrorState(
            message: e.toString(),
          ),
        );
      }
    });

    on<SelectSubCategory>((event, emit) async {
      emit(CategoriesLoadingState());
      try {
        emit(
          CategoriesLoadedState(
              categoriesResponseModel:
                  event.categoriesLoadedState.categoriesResponseModel,
              selectedCategory: event.categoryItem,
              selectedSubCategory: event.subcategory),
        );
      } catch (e) {
        emit(
          CategoriesErrorState(
            message: e.toString(),
          ),
        );
      }
    });
    on<SelectSubCategoryFromStart>((event, emit) async {
      emit(CategoriesLoadingState());
      try {
        emit(
          CategoriesLoadedState(
              categoriesResponseModel: event.categoriesLoadedState,
              selectedCategory: event.categoryItem,
              selectedSubCategory: event.subcategory),
        );
      } catch (e) {
        emit(
          CategoriesErrorState(
            message: e.toString(),
          ),
        );
      }
    });
  }
}
