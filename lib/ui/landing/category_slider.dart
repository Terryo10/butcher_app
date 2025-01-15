import 'package:butcher_app/state/bloc/categories_bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_defaults.dart';
import '../../themes/styles.dart';

class CategorySlider extends StatefulWidget {
  const CategorySlider({super.key});

  @override
  State<CategorySlider> createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
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
                        state.categoriesResponseModel?.categories?.categories
                                ?.data?.length ??
                            0, (index) {
                      return InkWell(
                        onTap: () {
                          BlocProvider.of<CategoriesBloc>(context).add(
                              GetSelectedSubCategory(
                                  selectedSubCategories: state
                                          .categoriesResponseModel
                                          ?.categories
                                          ?.categories
                                          ?.data?[index]
                                          .subcategories ??
                                      []));
                          setState(() {
                            activeMenu = index;
                          });
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
                                    state.categoriesResponseModel?.categories
                                            ?.categories?.data?[index].name ??
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
