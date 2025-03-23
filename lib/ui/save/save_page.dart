// lib/screens/save/save_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butcher_app/models/categories/product.dart';
import 'package:butcher_app/state/bloc/wishlist_bloc/wishlist_bloc.dart';

import '../../core/components/bundle_tile_square.dart';
import 'empty_save_page.dart';
import 'wishlist_product_card.dart';

class SavePage extends StatefulWidget {
  const SavePage({
    super.key,
    this.isHomePage = false,
  });

  final bool isHomePage;

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  @override
  void initState() {
    super.initState();
    // Load wishlist when page is opened
    context.read<WishlistBloc>().add(WishlistStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isHomePage
          ? null
          : AppBar(
              title: const Text('My Wishlist'),
              centerTitle: true,
            ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WishlistLoaded && state.products.isNotEmpty) {
            return _buildWishlistContent(context, state.products);
          } else if (state is WishlistError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else {
            // Empty wishlist or initial state
            return const EmptySavePage();
          }
        },
      ),
    );
  }

  Widget _buildWishlistContent(BuildContext context, List<Product> products) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<WishlistBloc>().add(WishlistStarted());
      },
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return BundleTileSquare(product: products[index]);
                  },
                  childCount: products.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
