// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDatum _$CategoryDatumFromJson(Map<String, dynamic> json) =>
    CategoryDatum(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      subcategories: (json['subcategories'] as List<dynamic>?)
          ?.map((e) => Subcategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryDatumToJson(CategoryDatum instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'subcategories': instance.subcategories,
    };
