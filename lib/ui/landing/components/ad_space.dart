import 'package:flutter/material.dart';

import '../../../constants/app_defaults.dart';
import '../../../core/components/network_image.dart';

class AdSpace extends StatelessWidget {
  const AdSpace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            width: 300,
            height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icons/grocery.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
