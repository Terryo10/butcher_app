import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_defaults.dart';
import '../../state/bloc/categories_bloc/categories_bloc.dart';
import '../../state/bloc/search_bloc/search_bloc.dart';
import '../landing/components/categories_chip.dart';

class ProductFiltersDialog extends StatefulWidget {
  const ProductFiltersDialog({super.key});

  @override
  State<ProductFiltersDialog> createState() => _ProductFiltersDialogState();
}

class _ProductFiltersDialogState extends State<ProductFiltersDialog> {
  int selectedIndex = 0;
  String selectedOrderBy = "Desc";
  String selectedCategory = "";
  RangeValues currentRangeValues = const RangeValues(40, 80);

  void updateOrderBy(String orderBy) {
    setState(() {
      selectedOrderBy = orderBy;
    });
  }

  void updatePriceRange(RangeValues ranges) {
    setState(() {
      currentRangeValues = ranges;
    });
  }

  void resetAllFiedsData(String text) {
    setState(() {
      currentRangeValues = const RangeValues(0, 80);
      selectedIndex = 0;
      selectedOrderBy = 'Desc';
    });
  }

  void updateCategory(String cat) {
    setState(() {
      selectedCategory = cat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 3,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 165, 139, 139),
                borderRadius: AppDefaults.borderRadius,
              ),
              margin: const EdgeInsets.all(8),
            ),
            _FilterHeader(
              onResetFieldsValues: resetAllFiedsData,
            ),
            _SortBy(
              selectedOrderBy: selectedOrderBy,
              onOrderByChanged: updateOrderBy,
            ),
            _PriceRange(
              currentRangeValues: currentRangeValues,
              onPriceRangeChange: updatePriceRange,
            ),
            _BrandSelector(
              selectedIndex: selectedIndex,
              onCategoryValueChange: updateCategory,
            ),

            // _RatingStar(
            //   totalStarsSelected: 4,
            //   onStarSelect: (v) {
            //     debugPrint('Star selected $v');
            //   },
            // ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    BlocProvider.of<SearchBloc>(context).add(
                        SearchAddFiltersToProduct(
                            selectedCategory: selectedCategory,
                            selectedOrder: selectedOrderBy,
                            selectedPriceRanges: currentRangeValues));
                  },
                  child: const Text('Apply Filter'),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _BrandSelector extends StatefulWidget {
  final int selectedIndex;

  final ValueChanged<String> onCategoryValueChange;
  const _BrandSelector({
    required this.selectedIndex,
    required this.onCategoryValueChange,
  });

  @override
  State<_BrandSelector> createState() => _BrandSelectorState();
}

class _BrandSelectorState extends State<_BrandSelector> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Categories',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoadedState) {
                return SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 16,
                    runSpacing: 16,
                    children: List.generate(state.categories.length, (index) {
                      return CategoriesChip(
                        isActive: selectedIndex == index,
                        label: state.categories[index].name ?? '',
                        onPressed: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          widget.onCategoryValueChange(index.toString());
                        },
                      );
                    }),
                  ),
                );
              } else if (state is CategoriesErrorState) {
                return CategoriesChip(
                  isActive: true,
                  label: 'Retry Fetching Categories',
                  onPressed: () {
                    BlocProvider.of<CategoriesBloc>(context)
                        .add(GetCategories());
                  },
                );
              } else if (state is CategoriesLoadingState) {
                return CategoriesChip(
                  isActive: true,
                  label: 'fetching data please wait...',
                  onPressed: () {},
                );
              }

              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}


class _PriceRange extends StatefulWidget {
  final RangeValues currentRangeValues;

  final ValueChanged<RangeValues> onPriceRangeChange;
  const _PriceRange({
    required this.currentRangeValues,
    required this.onPriceRangeChange,
  });

  @override
  State<_PriceRange> createState() => _PriceRangeState();
}

class _PriceRangeState extends State<_PriceRange> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Price Range',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
          ),
          RangeSlider(
            max: 100,
            min: 0,
            labels: RangeLabels(
              widget.currentRangeValues.start.round().toString(),
              widget.currentRangeValues.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              widget.onPriceRangeChange(values);
            },
            activeColor: AppColors.primary,
            inactiveColor: AppColors.gray,
            values: widget.currentRangeValues,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$0'),
                Text('\$50'),
                Text('\$100'),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SortBy extends StatefulWidget {
  final String selectedOrderBy;
  final ValueChanged<String> onOrderByChanged;
  const _SortBy({
    required this.selectedOrderBy,
    required this.onOrderByChanged,
  });

  @override
  State<_SortBy> createState() => _SortByState();
}

class _SortByState extends State<_SortBy> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Row(
        children: [
          Text(
            'Sort By',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
          const Spacer(),
          DropdownButton(
            value: widget.selectedOrderBy,
            underline: const SizedBox(),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: AppColors.primary,
            ),
            items: const [
              DropdownMenuItem(
                value: 'Asc',
                child: Text('Ascending Order'),
              ),
              DropdownMenuItem(
                value: 'Desc',
                child: Text('Descending Order'),
              ),
            ],
            onChanged: (v) {
              widget.onOrderByChanged(v ?? 'Desc');
            },
          )
        ],
      ),
    );
  }
}

class _FilterHeader extends StatelessWidget {
  final ValueChanged<String> onResetFieldsValues;
  const _FilterHeader({
    required this.onResetFieldsValues,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 56,
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 40,
            width: 40,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: AppColors.scaffoldWithBoxBackground,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Text(
          'Filter',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
        ),
        SizedBox(
          width: 56,
          child: TextButton(
            onPressed: () {
              onResetFieldsValues('sds');
            },
            child: Text(
              'Reset',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                  ),
            ),
          ),
        )
      ],
    );
  }
}
