// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      price: json['price'] as String?,
      pricingType: json['pricingType'] as String? ?? 'fixed',
      unit: json['unit'] as String?,
      weight: json['weight'] as String?,
      minQuantity: json['minQuantity'] as String?,
      maxQuantity: json['maxQuantity'] as String?,
      increment: json['increment'] as String?,
      stock: (json['stock'] as num?)?.toInt(),
      image: json['image'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: json['description'] as String?,
      subcategoryId: (json['subcategoryId'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'pricingType': instance.pricingType,
      'unit': instance.unit,
      'weight': instance.weight,
      'minQuantity': instance.minQuantity,
      'maxQuantity': instance.maxQuantity,
      'increment': instance.increment,
      'stock': instance.stock,
      'image': instance.image,
      'images': instance.images,
      'description': instance.description,
      'subcategoryId': instance.subcategoryId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
