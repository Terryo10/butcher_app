import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../models/categories/product.dart';
import '../../routes/router.gr.dart';
import '../../static/app_urls.dart';
import 'network_image.dart';

class BundleTileSquare extends StatelessWidget {
  const BundleTileSquare({
    super.key,
    required this.product,
  });

  final Product product;

  bool get isWeightBased => product.pricingType == 'weight';
  
  @override
  Widget build(BuildContext context) {
    final double price = product.priceAsDouble;
    
    return Material(
      color: AppColors.scaffoldBackground,
      borderRadius: AppDefaults.borderRadius,
      child: InkWell(
        onTap: () {
          // Using AutoRoute for navigation
          context.router.push(ProductDetailsRoute(product: product));
        },
        borderRadius: AppDefaults.borderRadius,
        child: Container(
          width: 176,
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          decoration: BoxDecoration(
            border: Border.all(width: 0.1, color: AppColors.placeholder),
            borderRadius: AppDefaults.borderRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: InkWell(
                    onTap: () {},
                    child: NetworkImageWithLoader(
                      AppUrls.getProductImage(product.image ?? ''),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              
              // Product Name and Unit Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (isWeightBased && product.unit != null)
                    Text(
                      'Sold by ${product.unit}',
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (!isWeightBased && product.description != null)
                    Text(
                      product.description ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
              
              // Price Row
              Row(
                children: [
                  // Format price based on pricing type
                  Text(
                    isWeightBased
                        ? '\$${price.toStringAsFixed(2)}/${product.unit ?? 'unit'}'
                        : '\$${price.toStringAsFixed(2)}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black),
                  ),
                  const SizedBox(width: 4),
                  // Only show if there's a discount (original price > current price)
                  if (product.price != null && price > 0)
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                    ),
                  const Spacer(),
                ],
              ),
              
              // Weight-based badge
              if (isWeightBased)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha:0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'By Weight',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.green[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                
              const SizedBox(height: 1),
            ],
          ),
        ),
      ),
    );
  }
}