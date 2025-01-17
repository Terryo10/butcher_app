import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? name;
  dynamic email;
  String? phone;
  String? verificationToken;
  String? otp;
  dynamic emailVerifiedAt;
  DateTime? phoneVerifiedAt;
  dynamic googleId;
  dynamic appleId;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.verificationToken,
    this.otp,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.googleId,
    this.appleId,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
