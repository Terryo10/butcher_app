import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_defaults.dart';
import '../../constants/app_icons.dart';
import '../../core/components/app_back_button.dart';
import '../../utils/ui_util.dart';
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
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 16),
              itemBuilder: (context, index) {
                return const SearchHistoryTile();
              },
              separatorBuilder: (context, index) => const Divider(
                thickness: 0.1,
              ),
              itemCount: 16,
            ),
          )
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
                    onChanged: (String? value) {},
                    onFieldSubmitted: (v) {},
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
  const SearchHistoryTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Row(
          children: [
            Text(
              'Vegetables',
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
