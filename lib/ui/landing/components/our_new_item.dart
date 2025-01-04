import 'package:flutter/material.dart';

import '../../../core/components/product_tile_square.dart';
import '../../../core/components/title_and_action_button.dart';

class OurNewItem extends StatelessWidget {
  const OurNewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndActionButton(
          title: 'Our New Item',
          onTap: () {
// Navigator.pushNamed(context, AppRoutes.popularItems)
          },
        ),
        // SingleChildScrollView(
        //   padding: const EdgeInsets.only(left: AppDefaults.padding),
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: List.generate(
        //       Dummy.products.length,
        //       (index) => ProductTileSquare(data: Dummy.products[index]),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
