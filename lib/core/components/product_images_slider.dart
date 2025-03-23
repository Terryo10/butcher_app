import 'package:butcher_app/models/categories/product.dart';
import 'package:butcher_app/state/bloc/wishlist_bloc/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_defaults.dart';
import '../../constants/app_icons.dart';
import '../../ui/landing/components/animated_dots.dart';
import 'network_image.dart';

class ProductImagesSlider extends StatefulWidget {
  const ProductImagesSlider({
    super.key,
    required this.images,
    required this.product,
  });

  final List<String> images;
  final Product product;

  @override
  State<ProductImagesSlider> createState() => _ProductImagesSliderState();
}

class _ProductImagesSliderState extends State<ProductImagesSlider> {
  late PageController controller;
  int currentIndex = 0;

  List<String> images = [];

  @override
  void initState() {
    super.initState();
    images = widget.images;
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: AppColors.coloredBackground,
        borderRadius: AppDefaults.borderRadius,
      ),
      height: MediaQuery.of(context).size.height * 0.35,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  onPageChanged: (v) {
                    currentIndex = v;
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(AppDefaults.padding),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: NetworkImageWithLoader(
                          images[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                  itemCount: images.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: AnimatedDots(
                  totalItems: images.length,
                  currentIndex: currentIndex,
                ),
              )
            ],
          ),
          Positioned(
            right: 0,
            child: Material(
              color: Colors.transparent,
              borderRadius: AppDefaults.borderRadius,
              child: BlocBuilder<WishlistBloc, WishlistState>(
                builder: (context, state) {
                  // Check product wishlist status if it has an ID
                  if (widget.product.id != null) {
                    context.read<WishlistBloc>().add(
                          CheckWishlistStatus(productId: widget.product.id!),
                        );
                  }

                  bool isInWishlist = false;
                  if (state is WishlistLoaded && widget.product.id != null) {
                    isInWishlist = state.isInWishlist(widget.product.id!);
                  }

                  return IconButton(
                    onPressed: () {
                      if (widget.product.id == null) return;

                      if (isInWishlist) {
                        context.read<WishlistBloc>().add(
                              RemoveFromWishlist(product: widget.product),
                            );
                      } else {
                        context.read<WishlistBloc>().add(
                              AddToWishlist(product: widget.product),
                            );
                      }
                    },
                    iconSize: 56,
                    constraints:
                        const BoxConstraints(minHeight: 56, minWidth: 56),
                    icon: Container(
                      padding: const EdgeInsets.all(AppDefaults.padding),
                      decoration: const BoxDecoration(
                        color: AppColors.scaffoldBackground,
                        shape: BoxShape.circle,
                      ),
                      child: isInWishlist
                          ? SvgPicture.asset(
                              AppIcons.heart,
                              colorFilter: const ColorFilter.mode(
                                Colors.red,
                                BlendMode.srcIn,
                              ),
                            )
                          : SvgPicture.asset(AppIcons.heart),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
