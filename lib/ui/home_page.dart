import 'package:auto_route/auto_route.dart';
import 'package:butcher_app/ui/landing/category_slider.dart';
import 'package:butcher_app/ui/landing/sub_category_slider.dart';
import 'package:butcher_app/ui/profile/order/orders_list_screen.dart';
import 'package:butcher_app/ui/save/save_page.dart';
import 'package:butcher_app/ui/side_bar/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_colors.dart';
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

  /// On bottom navigation tap
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
            return FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              fillColor: AppColors.scaffoldBackground,
              child: child,
            );
          },
          duration: const Duration(milliseconds: 300),
          child: pages[currentIndex],
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            shape: BoxShape.circle,
          ),
          child: FloatingActionButton(
            onPressed: () {
              onBottomNavigationTap(2);
            },
            backgroundColor: AppColors.primary,
            elevation: 4,
            child: SvgPicture.asset(
              AppIcons.cart,
              width: 24,
              height: 24,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
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
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Builder(builder: (context) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F6F3),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: SvgPicture.asset(
                        AppIcons.sidebarIcon,
                        width: 22,
                        height: 22,
                      ),
                      splashRadius: 24,
                    ),
                  );
                }),
              ),
              floating: true,
              backgroundColor: AppColors.scaffoldBackground,
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Image.asset(
                  "assets/icons/logo.png",
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Builder(builder: (context) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F6F3),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        icon: SvgPicture.asset(
                          AppIcons.search,
                          width: 22,
                          height: 22,
                        ),
                        splashRadius: 24,
                      ),
                    );
                  }),
                ),
              ],
            ),

            //categories
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
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

            // Footer space
            const SliverToBoxAdapter(
              child: SizedBox(height: 80),
            ),
          ],
        ),
      ),
    );
  }
}
