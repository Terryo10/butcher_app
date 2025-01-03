// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesResponseModel _$CategoriesResponseModelFromJson(
        Map<String, dynamic> json) =>
    CategoriesResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      categories: json['Categories'] == null
          ? null
          : Categories.fromJson(json['Categories'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoriesResponseModelToJson(
        CategoriesResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'Categories': instance.categories,
    };
