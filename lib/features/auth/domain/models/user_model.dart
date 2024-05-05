// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:trading/core/api/end_points.dart';

class UserModel {
  int? id;
  String? userName;
  String? fullName;
  String? gender;
  String? email;
  String? mobile;
  DateTime? emailVerifiedAt;
  String? password;
  String? profile;
  String? passport;
  String? passportBack;
  int? levelId = 2;
  String? rememberToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel({
    this.id,
    this.userName,
    this.fullName,
    this.gender,
    this.email,
    this.mobile,
    this.emailVerifiedAt,
    this.password,
    this.profile,
    this.passport,
    this.passportBack,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[ApiKey.data][ApiKey.id],
      userName: json[ApiKey.data][ApiKey.userName],
      fullName: json[ApiKey.data][ApiKey.fullName],
      gender: json[ApiKey.data][ApiKey.gender],
      email: json[ApiKey.data][ApiKey.email],
      mobile: json[ApiKey.data][ApiKey.mobile],
      emailVerifiedAt: json[ApiKey.data][ApiKey.emailVerifiedAt] != null
          ? DateTime.parse(json[ApiKey.data][ApiKey.emailVerifiedAt])
          : null,
      password: json[ApiKey.data][ApiKey.password],
      profile: json[ApiKey.data][ApiKey.profile],
      passport: json[ApiKey.data][ApiKey.passport],
      passportBack: json[ApiKey.data][ApiKey.passportBack],
      rememberToken: json[ApiKey.data][ApiKey.rememberToken],
      createdAt: DateTime.parse(json[ApiKey.data][ApiKey.createdAt]),
      updatedAt: DateTime.parse(json[ApiKey.data][ApiKey.updatedAt]),
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, userName: $userName, fullName: $fullName, gender: $gender, email: $email, mobile: $mobile, emailVerifiedAt: $emailVerifiedAt, password: $password, profile: $profile, passport: $passport, passportBack: $passportBack, levelId: $levelId, rememberToken: $rememberToken, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ApiKey.data: {
        ApiKey.id: id,
        ApiKey.userName: userName,
        ApiKey.fullName: fullName,
        ApiKey.gender: gender,
        ApiKey.email: email,
        ApiKey.mobile: mobile,
        ApiKey.emailVerifiedAt: emailVerifiedAt?.toString(),
        ApiKey.password: password,
        ApiKey.profile: profile,
        ApiKey.createdAt: createdAt?.toString(),
        ApiKey.updatedAt: updatedAt?.toString(),
      }
    };
  }

  String toJsonString() => json.encode(toJson());

  // factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}


/*
*Request Get parameter userId

*Response
!Success
{
  "data": {
    "id": 17,
    "first_name": "eslam",
    "last_name": "kamel",
    "email": "eslamm_kamelllll_89@hotmail.com",
    "mobile": "01024520809",
    "email_verified_at": null,
    "password": "$2y$12$VLN/b3fY7NZ/hFkdL/2ake5ZmW7GwZd5uPP2HMeXTVUevcWMn2Xtq",
    "profile": "1714751626.png",
    "passport": "1714751626.png",
    "passport_back": "1714751626.png",
    "level_id": 2,
    "remember_token": null,
    "created_at": "2024-05-03T15:53:46.000000Z",
    "updated_at": "2024-05-03T15:53:46.000000Z"
  },
  "status": "success",
  "error": false
}
!Failure
Status: 500 Internal Server Error

 */