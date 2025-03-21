import 'package:bloc/bloc.dart';
import 'package:butcher_app/repositories/products_repository/products_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../models/product_search/product_search_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductsRepository productsRepository;
  SearchBloc({required this.productsRepository})
      : super(SearchProductInitial()) {
    on<SearchProduct>(
      (event, emit) async {
        emit(SearchProductLoadingState());
        try {
          final currentState = state;
          String? selectedOrder;
          String? selectedCategory;
          RangeValues? selectedPriceRanges;

          if (currentState is SearchProductSelectFiltersState) {
           
            selectedOrder = currentState.selectedOrder;
            selectedCategory = currentState.selectedCategory;
            selectedPriceRanges = currentState.selectedPriceRanges;
          }
          var response = await productsRepository.searchProducts(
            name: event.name,
            order: selectedOrder,
            category: selectedCategory,
            minPrice: selectedPriceRanges?.start,
            maxPrice: selectedPriceRanges?.end,
          );
          emit(SearchProductLoadedState(searchResponse: response));
        } catch (e) {
          emit(
            SearchProductErrorState(
              message: e.toString(),
            ),
          );
        }
      },
    );

    on<SearchAddFiltersToProduct>(
      (event, emit) {
        emit(SearchProductSelectFiltersState(
            selectedOrder: event.selectedOrder,
            selectedCategory: event.selectedCategory,
            selectedPriceRanges: event.selectedPriceRanges));
      },
    );
  }
}
