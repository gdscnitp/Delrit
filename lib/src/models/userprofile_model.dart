import 'package:meta/meta.dart';
import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  UserProfileModel({
    required this.name,
    required this.tokens,
    required this.id,
    required this.email,
    required this.phone,
    required this.address,
    required this.gender,
    required this.age,
  });

  final String? name;
  final List<String> tokens;
  final String? id;
  final String? email;
  final String? phone;
  final String? address;
  final String? gender;
  final String? age;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        name: json["name"],
        tokens: List<String>.from(json["tokens"].map((x) => x)),
        id: json["id"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        gender: json["gender"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "tokens": List<dynamic>.from(tokens.map((x) => x)),
        "id": id,
        "email": email,
        "phone": phone,
        "address": address,
        "gender": gender,
        "age": age,
      };
}
