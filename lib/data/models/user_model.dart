// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  DateTime? emailVerifiedAt;
  String? phone;
  DateTime? phoneVerifiedAt;
  String? status;
  String? role;
  String? gender;
  int? userLangId;
  String? userLang;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? authToken;
  String? tokenType;
  int? tokenExpiresIn;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.phoneVerifiedAt,
    this.status,
    this.role,
    this.gender,
    this.userLangId,
    this.userLang,
    this.createdAt,
    this.updatedAt,
    this.authToken,
    this.tokenType,
    this.tokenExpiresIn,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        phone: json["phone"],
        phoneVerifiedAt: json["phone_verified_at"] == null
            ? null
            : DateTime.parse(json["phone_verified_at"]),
        status: json["status"],
        role: json["role"],
        gender: json["gender"],
        userLangId: json["user_lang_id"],
        userLang: json["user_lang"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        authToken: json["auth_token"],
        tokenType: json["token_type"],
        tokenExpiresIn: json["token_expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "phone": phone,
        "phone_verified_at": phoneVerifiedAt?.toIso8601String(),
        "status": status,
        "role": role,
        "gender": gender,
        "user_lang_id": userLangId,
        "user_lang": userLang,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "auth_token": authToken,
        "token_type": tokenType,
        "token_expires_in": tokenExpiresIn,
      };
}
