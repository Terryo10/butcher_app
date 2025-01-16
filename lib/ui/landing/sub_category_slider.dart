import 'package:butcher_app/state/bloc/categories_bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_defaults.dart';
import '../../models/categories/category_datum.dart';
import '../../models/categories/subcategory.dart';
import '../../themes/styles.dart';

class SubCategorySlider extends StatefulWidget {
  const SubCategorySlider({super.key});

  @override
  State<SubCategorySlider> createState() => _SubCategorySliderState();
}

class _SubCategorySliderState extends State<SubCategorySlider> {
  int activeMenu = 0;
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoadingState) {
          //SHIMMER HERE
          return const SliverToBoxAdapter(
            child: SizedBox(),
          );
        } else if (state is CategoriesLoadedState) {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding),
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        state.selectedCategory?.subcategories?.length ?? 0,
                        (index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            activeMenu = index;
                          });

                          BlocProvider.of<CategoriesBloc>(context).add(
                            SelectSubCategory(
                                categoriesLoadedState: state,
                                categoryItem:
                                    state.selectedCategory ?? CategoryDatum(),
                                subcategory: state.selectedCategory
                                        ?.subcategories?[index] ??
                                    Subcategory()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: activeMenu == index
                                  ? Colors.black
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                top: 8,
                                right: 15,
                                bottom: 8,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    state.selectedCategory
                                            ?.subcategories?[index].name ??
                                        '',
                                    style: activeMenu == index
                                        ? appStyleText
                                        : appStyleTextActive,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
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
