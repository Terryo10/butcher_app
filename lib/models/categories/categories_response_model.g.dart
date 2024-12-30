// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesModel _$CategoriesModelFromJson(Map<String, dynamic> json) =>
    CategoriesModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      categories: json['categories'] == null
          ? null
          : Categories.fromJson(json['categories'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoriesModelToJson(CategoriesModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'categories': instance.categories,
    };
