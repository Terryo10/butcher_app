import 'package:auto_route/auto_route.dart';
import 'package:butcher_app/models/categories/category_datum.dart';
import 'package:butcher_app/state/bloc/categories_bloc/categories_bloc.dart';

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

          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding),
            sliver: SliverToBoxAdapter(
              child: BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoadedState) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(state.categories.length,
                                  (index) {
                                return InkWell(
                                  onTap: () {
                                    BlocProvider.of<CategoriesBloc>(context)
                                        .add(
                                      SelectCategory(
                                        categoriesLoadedState: state,
                                        categoryItem: state.categories[index],
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: state.categories.indexOf(
                                                    state.selectedCategory ??
                                                        CategoryDatum()) ==
                                                index
                                            ? Colors.black
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                          top: 8,
                                          right: 15,
                                          bottom: 8,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              state.categories[index].name ??
                                                  '',
                                              style: state.categories.indexOf(
                                                          state.selectedCategory ??
                                                              CategoryDatum()) ==
                                                      index
                                                  ? appStyleText
                                                  : appStyleTextActive,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                  state.selectedCategory?.subcategories
                                          ?.length ??
                                      0, (index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      activeMenu = index;
                                    });

                                    BlocProvider.of<CategoriesBloc>(context)
                                        .add(
                                      SelectSubCategory(
                                          categoriesLoadedState: state,
                                          categoryItem:
                                              state.selectedCategory ??
                                                  CategoryDatum(),
                                          subcategory: state.selectedCategory
                                                  ?.subcategories?[index] ??
                                              Subcategory()),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: activeMenu == index
                                            ? Colors.black
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                          top: 8,
                                          right: 15,
                                          bottom: 8,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              state
                                                      .selectedCategory
                                                      ?.subcategories?[index]
                                                      .name ??
                                                  '',
                                              style: activeMenu == index
                                                  ? appStyleText
                                                  : appStyleTextActive,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),

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
