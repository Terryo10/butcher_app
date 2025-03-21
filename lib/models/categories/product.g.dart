// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      price: json['price'] as String?,
      stock: (json['stock'] as num?)?.toInt(),
      image: json['image'] as String?,
      description: json['description'] as String?,
      subcategoryId: (json['subcategoryId'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'stock': instance.stock,
      'image': instance.image,
      'images': instance.images,
      'description': instance.description,
      'subcategoryId': instance.subcategoryId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
