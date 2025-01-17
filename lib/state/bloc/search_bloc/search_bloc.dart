import 'package:bloc/bloc.dart';
import 'package:butcher_app/repositories/products_repository/products_repository.dart';
import 'package:equatable/equatable.dart';

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
          var response =
              await productsRepository.searchProducts(name: event.name);
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
  }
}
