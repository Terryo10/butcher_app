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
                  padding: const EdgeInsets.only(left: AppDefaults.padding),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      state.selectedProducts?.products?.length ?? 0,
                      (index) => Padding(
                        padding:
                            const EdgeInsets.only(right: AppDefaults.padding),
                        child: BundleTileSquare(
                            data: state.selectedProducts?.products?[index] ??
                                Product()),
                      ),
                    ),
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
