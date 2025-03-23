import 'package:butcher_app/state/bloc/categories_bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_defaults.dart';
import '../../../core/components/bundle_tile_square.dart';
import '../../../core/components/title_and_action_button.dart';

class PopularPacks extends StatelessWidget {
  const PopularPacks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          child: TitleAndActionButton(
            title: 'Popular Packs',
            onTap: () {
              // Navigator.pushNamed(context, AppRoutes.popularItems)
            },
          ),
        ),
        BlocListener<CategoriesBloc, CategoriesState>(
          listener: (context, state) {},
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoadingState) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state is CategoriesLoadedState) {
                final products = state.selectedSubCategory?.products ?? [];

                if (products.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.shopping_basket_outlined,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No products available",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Please select a different category",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDefaults.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          // Use the existing BundleTileSquare widget
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
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return BundleTileSquare(
                                product: products[index],
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 24),
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
