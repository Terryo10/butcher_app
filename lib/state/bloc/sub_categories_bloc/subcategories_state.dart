part of 'subcategories_bloc.dart';

sealed class SubcategoriesState extends Equatable {
  const SubcategoriesState();
  
  @override
  List<Object> get props => [];
}

final class SubcategoriesInitial extends SubcategoriesState {}
