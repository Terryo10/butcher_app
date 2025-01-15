import 'package:butcher_app/models/categories/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subcategory.g.dart';

@JsonSerializable()
class Subcategory {
  int? id;
  String? name;
  dynamic image;
  int? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  @JsonKey(name: 'products')
  List<Product>? products;

  Subcategory({
    this.id,
    this.name,
    this.image,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryToJson(this);
}
