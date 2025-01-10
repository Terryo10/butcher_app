import 'package:flutter/material.dart';

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
          },
        ),

      ],
    );
  }
}
