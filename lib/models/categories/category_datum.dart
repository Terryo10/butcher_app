import 'subcategory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_datum.g.dart';

@JsonSerializable()
class CategoryDatum {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Subcategory>? subcategories;

  CategoryDatum({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.subcategories,
  });

  factory CategoryDatum.fromJson(Map<String, dynamic> json) =>
      _$CategoryDatumFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDatumToJson(this);
}
