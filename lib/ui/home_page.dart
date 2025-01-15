import 'package:auto_route/auto_route.dart';
import 'package:butcher_app/ui/landing/sub_category_slider.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../constants/app_defaults.dart';
import '../constants/app_icons.dart';
import 'landing/category_slider.dart';
import 'landing/components/ad_space.dart';
import 'landing/components/our_new_item.dart';
import 'landing/components/popular_packs.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, AppRoutes.drawerPage);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF2F6F3),
                  shape: const CircleBorder(),
                ),
                child: SvgPicture.asset(AppIcons.sidebarIcon),
              ),
            ),
            floating: true,
            title: SvgPicture.asset(
              "assets/images/app_logo.svg",
              height: 32,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, AppRoutes.search);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF2F6F3),
                    shape: const CircleBorder(),
                  ),
                  child: SvgPicture.asset(AppIcons.search),
                ),
              ),
            ],
          ),
          const CategorySlider(),
          const SubCategorySlider(),
          const SliverToBoxAdapter(
            child: AdSpace(),
          ),
          const SliverToBoxAdapter(
            child: PopularPacks(),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: AppDefaults.padding),
            sliver: SliverToBoxAdapter(
              child: OurNewItem(),
            ),
          ),
        ],
      ),
    ));
  }
}
