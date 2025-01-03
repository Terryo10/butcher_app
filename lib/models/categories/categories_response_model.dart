import 'categories_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categories_response_model.g.dart';

@JsonSerializable()
class CategoriesResponseModel {
  bool? success;
  String? message;
  @JsonKey(name: 'Categories')
  Categories? categories;

  CategoriesResponseModel({
    this.success,
    this.message,
    this.categories,
  });

  factory CategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseModelToJson(this);
}
