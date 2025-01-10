import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../constants/app_images.dart';
import 'components/intro_page_background_wrapper.dart';
import 'components/intro_page_body_area.dart';

@RoutePage()
class IntroLoginPage extends StatelessWidget {
  const IntroLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          IntroLoginBackgroundWrapper(imageURL: AppImages.introBackground1),
          IntroPageBodyArea(),
        ],
      ),
    );
  }
}
