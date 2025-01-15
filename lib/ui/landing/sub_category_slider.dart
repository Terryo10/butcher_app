import 'package:butcher_app/state/bloc/categories_bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_defaults.dart';
import '../../models/categories/categories_response_model_test.dart';
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
                        state.selectedSubCategories?.length ?? 0, (index) {
                      return InkWell(
                        onTap: () {
                          BlocProvider.of<CategoriesBloc>(context).add(
                              GetSelectedProducts(
                                  selectedProducts:
                                      state.selectedSubCategories?[index] ??
                                          Subcategory()));
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
                                    state.selectedSubCategories?[index].name ??
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
