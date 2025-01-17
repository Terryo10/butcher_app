import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  String? message;
  User? user;
  String? token;

  LoginResponseModel({
    this.message,
    this.user,
    this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
