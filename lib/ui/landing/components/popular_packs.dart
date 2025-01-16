import 'package:butcher_app/state/bloc/categories_bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_defaults.dart';
import '../../../constants/dummy_data.dart';
import '../../../core/components/bundle_tile_square.dart';
import '../../../core/components/title_and_action_button.dart';
import '../../../models/categories/categories_response_model_test.dart';

class PopularPacks extends StatelessWidget {
  const PopularPacks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndActionButton(
          title: 'Popular Packs',
          onTap: () {
// Navigator.pushNamed(context, AppRoutes.popularItems)
          },
        ),
        BlocListener<CategoriesBloc, CategoriesState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoadedState) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDefaults.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          // Ensure GridView gets constraints from LayoutBuilder
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Two items per row
                              crossAxisSpacing: AppDefaults.padding,
                              mainAxisSpacing: AppDefaults.padding,
                              childAspectRatio: 0.8, // Adjust for item height
                            ),
                            itemCount:
                                state.selectedSubCategory?.products?.length ??
                                    0,
                            itemBuilder: (context, index) {
                              return BundleTileSquare(
                                data: state.selectedSubCategory
                                        ?.products?[index] ??
                                    Product(),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
