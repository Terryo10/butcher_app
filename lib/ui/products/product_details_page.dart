import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../constants/app_defaults.dart';
import '../../core/components/app_back_button.dart';
import '../../core/components/buy_now_row_button.dart';
import '../../core/components/price_and_quantity.dart';
import '../../core/components/product_images_slider.dart';
import '../../core/components/review_row_button.dart';

@RoutePage()
class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});

  final dynamic product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(widget.product?.name ?? 'Product Details'),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: BuyNowRow(
            onBuyButtonTap: () {},
            onCartButtonTap: () {},
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProductImagesSlider(
              images: [
                'https://i.imgur.com/3o6ons9.png',
                'https://i.imgur.com/3o6ons9.png',
                'https://i.imgur.com/3o6ons9.png',
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name ?? 'Product Details',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(widget.product.description ?? 'Product Description'),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: PriceAndQuantityRow(
                currentPrice:
                    double.tryParse(widget.product?.price?.toString() ?? '0') ??
                        0.0,
                orginalPrice:
                    double.tryParse(widget.product?.price?.toString() ?? '0') ??
                        0.0,
                quantity: widget.product?.stock ?? 0,
              ),
            ),
            const SizedBox(height: 8),

            /// Review Row
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDefaults.padding,
                // vertical: AppDefaults.padding,
              ),
              child: Column(
                children: [
                  Divider(thickness: 0.1),
                  ReviewRowButton(totalStars: 5),
                  Divider(thickness: 0.1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
