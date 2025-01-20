import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_defaults.dart';
import '../../constants/app_icons.dart';
import '../../core/components/app_back_button.dart';
import '../../models/product_search/product_search_model.dart';
import '../../state/bloc/search_bloc/search_bloc.dart';
import '../../utils/ui_util.dart';
import '../products/product_details_page.dart';
import 'products_filter_dialogue.dart';

class SearchDrawer extends StatelessWidget {
  const SearchDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _SearchPageHeader(),
            SizedBox(height: 8),
            _RecentSearchList(),
          ],
        ),
      ),
    );
  }
}

class _RecentSearchList extends StatelessWidget {
  const _RecentSearchList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Search',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
          ),
          BlocListener<SearchBloc, SearchState>(
            listener: (context, state) {},
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchProductLoadedState) {
                  return Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 16),
                      itemBuilder: (context, index) {
                        return SearchHistoryTile(
                          product: state.searchResponse.products?.products
                                  ?.data?[index] ??
                              ProductSearchDatum(),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 0.1,
                      ),
                      itemCount: state.searchResponse.products?.products?.data
                              ?.length ??
                          0,
                    ),
                  );
                } else if (state is SearchProductLoadingState) {
                  return const SizedBox(
                      child: Text('Fetching data please wait...'));
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchPageHeader extends StatelessWidget {
  const _SearchPageHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppDefaults.padding),
      child: Row(
        children: [
          const AppBackButton(),
          const SizedBox(width: 16),
          Expanded(
            child: Stack(
              children: [
                /// Search Box
                Form(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      contentPadding: EdgeInsets.zero,
                    ),
                    textInputAction: TextInputAction.search,
                    autofocus: true,
                    onChanged: (String? value) {
                      BlocProvider.of<SearchBloc>(context)
                          .add(SearchProduct(name: value ?? ''));
                    },
                    onFieldSubmitted: (v) {
                      BlocProvider.of<SearchBloc>(context)
                          .add(SearchProduct(name: v));
                    },
                  ),
                ),
                Positioned(
                  right: 0,
                  height: 40,
                  child: SizedBox(
                    width: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        UiUtil.openBottomSheet(
                          context: context,
                          widget: const ProductFiltersDialog(),
                        );
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
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchHistoryTile extends StatelessWidget {
  const SearchHistoryTile({super.key, required this.product});
  final ProductSearchDatum product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Row(
          children: [
            Text(
              product.name ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            SvgPicture.asset(AppIcons.searchTileArrow),
          ],
        ),
      ),
    );
  }
}
