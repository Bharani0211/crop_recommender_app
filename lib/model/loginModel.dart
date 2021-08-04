// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.id,
    required this.accessToken,
    required this.area,
    required this.district,
    required this.email,
    required this.state,
    required this.username,
    required this.villageTaluk,
  });

  String id;
  String accessToken;
  String area;
  String district;
  String email;
  String state;
  String username;
  String villageTaluk;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json["_id"],
        accessToken: json["access_token"],
        area: json["area"],
        district: json["district"],
        email: json["email"],
        state: json["state"],
        username: json["username"],
        villageTaluk: json["village_taluk"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "access_token": accessToken,
        "area": area,
        "district": district,
        "email": email,
        "state": state,
        "username": username,
        "village_taluk": villageTaluk,
      };
}
