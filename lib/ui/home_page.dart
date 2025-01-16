import 'package:auto_route/auto_route.dart';
import 'package:butcher_app/models/categories/category_datum.dart';
import 'package:butcher_app/state/bloc/categories_bloc/categories_bloc.dart';
import 'package:butcher_app/ui/landing/category_slider.dart';
import 'package:butcher_app/ui/landing/sub_category_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';

import '../constants/app_defaults.dart';
import '../constants/app_icons.dart';
import '../models/categories/subcategory.dart';
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
  int activeMenu = 0;
  bool isSearching = false;

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
          //categories
          const CategorySlider(),
          const SliverToBoxAdapter(
            child: AdSpace(),
          ),
          const SubCategorySlider(),
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

const primaryColor = Colors.black;
const appTextColor = Colors.grey;
TextStyle iconText = const TextStyle(fontSize: 20, fontWeight: FontWeight.w100);
TextStyle appStyleText = const TextStyle(
    color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle appStyleTextActive = const TextStyle(
    color: primaryColor, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle appBigTitle = const TextStyle(
    color: primaryColor, fontSize: 25, fontWeight: FontWeight.w500);
TextStyle textWithUnderline = TextStyle(
    color: Colors.blue.shade400, fontSize: 16, fontWeight: FontWeight.w500);
