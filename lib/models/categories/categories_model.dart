import 'package:json_annotation/json_annotation.dart';

import 'category_item_model.dart';

part 'categories_model.g.dart';

@JsonSerializable()
class Categories {
    CategoryItem? categories;
    Categories({
        this.categories,
    });

    factory Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesToJson(this);

}