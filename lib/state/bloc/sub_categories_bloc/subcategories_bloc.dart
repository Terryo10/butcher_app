import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'subcategories_event.dart';
part 'subcategories_state.dart';

class SubcategoriesBloc extends Bloc<SubcategoriesEvent, SubcategoriesState> {
  SubcategoriesBloc() : super(SubcategoriesInitial()) {
    on<SubcategoriesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
