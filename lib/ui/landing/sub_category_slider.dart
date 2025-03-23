import 'package:butcher_app/state/bloc/categories_bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_defaults.dart';
import '../../models/categories/category_datum.dart';

class SubCategorySlider extends StatefulWidget {
  const SubCategorySlider({super.key});

  @override
  State<SubCategorySlider> createState() => _SubCategorySliderState();
}

class _SubCategorySliderState extends State<SubCategorySlider> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoadingState) {
          return const SliverToBoxAdapter(
            child: SizedBox(),
          );
        } else if (state is CategoriesLoadedState) {
          final subcategories = state.selectedCategory?.subcategories ?? [];

          if (subcategories.isEmpty) {
            return const SliverToBoxAdapter(child: SizedBox());
          }

          return SliverPadding(
            padding:
                const EdgeInsets.symmetric(vertical: AppDefaults.padding / 2),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 12),
                    child: Text(
                      "Subcategories",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(subcategories.length, (index) {
                          // Check if this subcategory is the selected one in the state
                          final isSelected = state.selectedSubCategory?.id ==
                              subcategories[index].id;

                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  BlocProvider.of<CategoriesBloc>(context).add(
                                    SelectSubCategory(
                                      categoriesLoadedState: state,
                                      categoryItem: state.selectedCategory ??
                                          CategoryDatum(),
                                      subcategory: subcategories[index],
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(24),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF4A6572)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF4A6572)
                                          : Colors.grey.shade300,
                                      width: 1.5,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: const Color(0xFF4A6572)
                                                  .withOpacity(0.2),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            )
                                          ]
                                        : null,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    subcategories[index].name ?? '',
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black87,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        } else if (state is CategoriesErrorState) {
          return const SliverToBoxAdapter(
            child: SizedBox(),
          );
        } else {
          return const SliverToBoxAdapter(
            child: SizedBox(),
          );
        }
      },
    );
  }
}
