import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int? id;
  String? name;
  String? price;
  String? pricingType; // 'fixed' or 'weight'
  String? unit; // kg, g, piece, etc.
  String? weight; // Weight per unit (for weight-based products)
  String? minQuantity; // Minimum order quantity
  String? maxQuantity; // Maximum order quantity
  String? increment; // Increment steps for weight
  int? stock;
  String? image;
  List<String>? images;
  String? description;
  int? subcategoryId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
    this.id,
    this.name,
    this.price,
    this.pricingType = 'fixed',
    this.unit,
    this.weight,
    this.minQuantity,
    this.maxQuantity,
    this.increment,
    this.stock,
    this.image,
    this.images,
    this.description,
    this.subcategoryId,
    this.createdAt,
    this.updatedAt,
  });

  // Helper methods
  bool get isWeightBased => pricingType == 'weight';

  double get priceAsDouble => double.tryParse(price ?? '0') ?? 0;
  double? get weightAsDouble => double.tryParse(weight ?? '');
  double? get minQuantityAsDouble => double.tryParse(minQuantity ?? '');
  double? get maxQuantityAsDouble => double.tryParse(maxQuantity ?? '');
  double? get incrementAsDouble => double.tryParse(increment ?? '');

  // Format price for display
  String get formattedPrice {
    if (isWeightBased) {
      return '\$${priceAsDouble.toStringAsFixed(2)}/${unit ?? 'kg'}';
    }
    return '\$${priceAsDouble.toStringAsFixed(2)}';
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
