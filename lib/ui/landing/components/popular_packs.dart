import 'package:flutter/material.dart';

import '../../../constants/app_defaults.dart';
import '../../../constants/dummy_data.dart';
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
        TitleAndActionButton(
          title: 'Popular Packs',
          onTap: () {
// Navigator.pushNamed(context, AppRoutes.popularItems)
          },
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.only(left: AppDefaults.padding),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              Dummy.bundles.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: AppDefaults.padding),
                child: BundleTileSquare(data: Dummy.bundles[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
