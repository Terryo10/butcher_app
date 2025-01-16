import 'package:auto_route/auto_route.dart';
import 'package:butcher_app/ui/landing/category_slider.dart';
import 'package:butcher_app/ui/landing/sub_category_slider.dart';
import 'package:butcher_app/ui/side_bar/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_icons.dart';
import 'landing/components/ad_space.dart';
import 'landing/components/popular_packs.dart';
import 'search/search_drawer.dart';

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
      drawer: const SideBarPage(),
      endDrawer: const SearchDrawer(),
        body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                     Scaffold.of(context).openDrawer();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF2F6F3),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(
                          12), // Ensure there is enough padding
                    ),
                    child: SvgPicture.asset(
                      AppIcons.sidebarIcon,
                      width: 24, // Set a fixed size for the icon
                      height: 24, // Set a fixed size for the icon
                    ),
                  );
                }
              ),
            ),
            floating: true,
            title: Container(
              width: 300,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/logo.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
                child: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF2F6F3),
                        shape: const CircleBorder(),
                      ),
                      child: SvgPicture.asset(AppIcons.search),
                    );
                  }
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
