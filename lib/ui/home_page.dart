import 'package:auto_route/auto_route.dart';
import 'package:butcher_app/ui/landing/category_slider.dart';
import 'package:butcher_app/ui/landing/sub_category_slider.dart';
import 'package:butcher_app/ui/profile/order/orders_list_screen.dart';
import 'package:butcher_app/ui/save/save_page.dart';
import 'package:butcher_app/ui/side_bar/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_defaults.dart';
import '../constants/app_icons.dart';
import 'bottom_nav/app_navigation_bar.dart';
import 'cart/cart_page.dart';
import 'landing/components/ad_space.dart';
import 'landing/components/popular_packs.dart';
import 'profile/profile_page.dart';
import 'search/search_drawer.dart';
import 'package:animations/animations.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeMenu = 0;
  bool isSearching = false;
  int currentIndex = 0;

  /// On labelLarge navigation tap
  void onBottomNavigationTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  /// All the pages
  final List<Widget> pages = [
    const HomeSub(),
    const OrdersListPage(),
    const CartPage(isHomePage: true),
    const SavePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent going back
      child: Scaffold(
        body: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              fillColor: AppColors.scaffoldBackground,
              child: child,
            );
          },
          duration: AppDefaults.duration,
          child: pages[currentIndex],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            onBottomNavigationTap(2);
          },
          backgroundColor: AppColors.primary,
          child: SvgPicture.asset(AppIcons.cart),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AppBottomNavigationBar(
          currentIndex: currentIndex,
          onNavTap: onBottomNavigationTap,
        ),
      ),
    );
  }
}

class HomeSub extends StatelessWidget {
  const HomeSub({super.key});

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
                  child: Builder(builder: (context) {
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
                  }),
                ),
                floating: true,
                title: Container(
                  width: 300,
                  height: 300,
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
                    child: Builder(builder: (context) {
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
                    }),
                  ),
                ],
              ),
              //categories
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
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
