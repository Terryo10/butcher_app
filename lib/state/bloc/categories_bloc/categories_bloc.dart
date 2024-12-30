import 'package:bloc/bloc.dart';
import 'package:butcher_app/repositories/products_repository/products_repository.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final ProductsRepository productsRepository;
  CategoriesBloc({required this.productsRepository}) : super(CategoriesInitial()) {
    on<GetCategories>((event, emit) async {
      final categories =productsRepository.getCategories();
      
    });
  }
}
