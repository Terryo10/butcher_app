// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'],
      phone: json['phone'] as String?,
      verificationToken: json['verificationToken'] as String?,
      otp: json['otp'] as String?,
      emailVerifiedAt: json['emailVerifiedAt'],
      phoneVerifiedAt: json['phoneVerifiedAt'] == null
          ? null
          : DateTime.parse(json['phoneVerifiedAt'] as String),
      googleId: json['googleId'],
      appleId: json['appleId'],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'verificationToken': instance.verificationToken,
      'otp': instance.otp,
      'emailVerifiedAt': instance.emailVerifiedAt,
      'phoneVerifiedAt': instance.phoneVerifiedAt?.toIso8601String(),
      'googleId': instance.googleId,
      'appleId': instance.appleId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
