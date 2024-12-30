import 'categories_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categories_response_model.g.dart';

@JsonSerializable()
class CategoriesModel {
  bool? success;
  String? message;
  Categories? categories;

  CategoriesModel({
    this.success,
    this.message,
    this.categories,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesModelToJson(this);
}
