import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'category_slider.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const Scaffold(
        body: Column(
          children: [
            CategorySlider(),
            Text('shdusdh'),
          ],
        ),
      ),
    );
  }
}
