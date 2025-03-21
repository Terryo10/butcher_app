import 'package:butcher_app/state/bloc/categories_bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_defaults.dart';
import '../../models/categories/category_datum.dart';
import '../../themes/styles.dart';
import 'components/categories_chip.dart';

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
            child: SizedBox(child: Text('Loaind data please wait...')),
          );
        } else if (state is CategoriesLoadedState) {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding),
            sliver: SliverToBoxAdapter(
              child: BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesErrorState) {
                    return CategoriesChip(
                      isActive: true,
                      label: 'Retry Fetching Categories',
                      onPressed: () {
                        BlocProvider.of<CategoriesBloc>(context)
                            .add(GetCategories());
                      },
                    );
                  }
                  if (state is CategoriesLoadedState) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(state.categories.length,
                                  (index) {
                                return InkWell(
                                  onTap: () {
                                    BlocProvider.of<CategoriesBloc>(context)
                                        .add(
                                      SelectCategory(
                                        categoriesLoadedState: state,
                                        categoryItem: state.categories[index],
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: state.categories.indexOf(
                                                    state.selectedCategory ??
                                                        CategoryDatum()) ==
                                                index
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
                                              state.categories[index].name ??
                                                  '',
                                              style: state.categories.indexOf(
                                                          state.selectedCategory ??
                                                              CategoryDatum()) ==
                                                      index
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
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
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
