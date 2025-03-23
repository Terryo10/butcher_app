import 'package:auto_route/auto_route.dart';
import 'package:butcher_app/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_defaults.dart';
import 'app_back_button.dart';
import 'buy_now_row_button.dart';
import 'price_and_quantity.dart';
import 'product_images_slider.dart';
import 'review_row_button.dart';
import '../../state/bloc/cart_bloc/cart_bloc.dart';
import '../../static/app_urls.dart';
import '../../ui/products/weight_quantity_selector.dart';

@RoutePage()
class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});

  final dynamic product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  // For fixed-price products
  int quantity = 1;

  // For weight-based products
  double weightQuantity = 0.5;

  bool get isWeightBased => widget.product?.pricingType == 'weight';

  // Method to update quantity for fixed-price products
  void _updateQuantity(int newQuantity) {
    setState(() {
      quantity = newQuantity;
    });
  }

  // Method to update weight for weight-based products
  void _updateWeight(double newWeight) {
    setState(() {
      weightQuantity = newWeight;
    });
  }

  @override
  void initState() {
    super.initState();

    // Set initial weight from product's minimum quantity if available
    if (isWeightBased && widget.product?.minQuantity != null) {
      try {
        weightQuantity = double.parse(widget.product.minQuantity.toString());
      } catch (e) {
        // Default to 0.5 if parsing fails
        weightQuantity = 0.5;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(widget.product?.name ?? 'Product Details'),
        actions: [
          // Add cart badge
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded && state.cart.items.isNotEmpty) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        context.navigateTo(CartRoute());
                      },
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${state.cart.items.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  // Navigate to cart page
                  context.navigateTo(CartRoute());
                },
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              if (state is CartLoaded && state.message != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                    action: SnackBarAction(
                      label: 'VIEW CART',
                      onPressed: () {
                        context.navigateTo(CartRoute());
                      },
                    ),
                  ),
                );
              } else if (state is CartError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: BuyNowRow(
              onBuyButtonTap: () {
                // First add to cart, then navigate to checkout
                _addToCart();
                context.navigateTo(const CheckoutRoute());
              },
              onCartButtonTap: () {
                // Add to cart
                _addToCart();
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: ProductImagesSlider(
                images: [
                  AppUrls.getProductImage(widget.product?.image ??
                      ''), // Add the default image first
                  ...?widget.product?.images?.map((img) =>
                      AppUrls.getProductImage(
                          img)), // Spread the existing images
                ],
                product: widget.product,
              ),
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

                    // Display pricing type and unit if applicable
                    if (isWeightBased && widget.product.unit != null)
                      Chip(
                        label: Text('Sold by ${widget.product.unit}'),
                        backgroundColor: Theme.of(context)
                            .primaryColor
                            .withValues(alpha: 0.1),
                      ),

                    const SizedBox(height: 8),
                    Text(widget.product.description ?? 'Product Description'),
                  ],
                ),
              ),
            ),

            // Different quantity selectors based on product type
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: isWeightBased
                  ? _buildWeightBasedSelector()
                  : _buildFixedPriceSelector(),
            ),

            const SizedBox(height: 8),

            /// Review Row
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDefaults.padding,
              ),
              child: Column(
                children: [
                  Divider(thickness: 0.1),
                  ReviewRowButton(totalStars: 5),
                  Divider(thickness: 0.1),
                ],
              ),
            ),

            // Stock information if available
            if (widget.product.stock != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDefaults.padding,
                  vertical: AppDefaults.padding / 2,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.inventory_2,
                      size: 18,
                      color: _getStockColor(widget.product.stock),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _getStockStatus(widget.product.stock),
                      style: TextStyle(
                        color: _getStockColor(widget.product.stock),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Build the selector for weight-based products
  Widget _buildWeightBasedSelector() {
    final double pricePerUnit =
        double.tryParse(widget.product.price?.toString() ?? '0') ?? 0.0;
    final String unit = widget.product.unit ?? 'kg';

    // Parse min, max, and increment values
    double? minQuantity;
    if (widget.product.minQuantity != null) {
      minQuantity = double.tryParse(widget.product.minQuantity.toString());
    }

    double? maxQuantity;
    if (widget.product.maxQuantity != null) {
      maxQuantity = double.tryParse(widget.product.maxQuantity.toString());
    }

    double? increment;
    if (widget.product.increment != null) {
      increment = double.tryParse(widget.product.increment.toString());
    }

    return WeightQuantitySelector(
      initialWeight: weightQuantity,
      pricePerUnit: pricePerUnit,
      unit: unit,
      minQuantity: minQuantity,
      maxQuantity: maxQuantity,
      increment: increment,
      onWeightChanged: _updateWeight,
    );
  }

  // Build the selector for fixed-price products
  Widget _buildFixedPriceSelector() {
    final double price =
        double.tryParse(widget.product?.price?.toString() ?? '0') ?? 0.0;

    return PriceAndQuantityRow(
      currentPrice: price,
      orginalPrice: price, // Original price could be different if on sale
      quantity: quantity,
      onQuantityChanged: _updateQuantity,
    );
  }

  void _addToCart() {
    if (widget.product != null) {
      // Extract product details
      final int productId = widget.product.id;
      final String name = widget.product.name ?? 'Unknown Product';
      final double price =
          double.tryParse(widget.product.price?.toString() ?? '0') ?? 0.0;
      final String image = widget.product.image ?? '';

      // Get optional fields if available
      final String? unit = widget.product.unit;
      final String? pricingType = widget.product.pricingType ?? 'fixed';

      // Use the correct quantity based on product type
      final dynamic selectedQuantity =
          isWeightBased ? weightQuantity : quantity;

      // Add to cart through the bloc
      context.read<CartBloc>().add(
            AddToCart(
              productId: productId,
              name: name,
              price: price,
              image: image,
              quantity: selectedQuantity,
              unit: unit,
              pricingType: pricingType,
              unitPrice: price,
            ),
          );
    }
  }

  Color _getStockColor(int stock) {
    if (stock > 20) return Colors.green;
    if (stock > 5) return Colors.orange;
    return stock > 0 ? Colors.red : Colors.grey;
  }

  String _getStockStatus(int stock) {
    if (stock > 20) return 'In Stock ($stock available)';
    if (stock > 5) return 'Limited Stock ($stock left)';
    if (stock > 0) return 'Low Stock ($stock left)';
    return 'Out of Stock';
  }
}
