import 'dart:convert';

UserProfileModel userProfileFromJson(Map<String, dynamic>? data) =>
    UserProfileModel.fromJson(data!);

String userProfileToJson(UserProfileModel data) => json.encode(data.toJson());

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
    required this.profile,
  });

  final String? name;
  final List<String> tokens;
  final String? id;
  final String? email;
  final String? phone;
  final String? address;
  final String? gender;
  final String? age;
  String profile =
      "https://firebasestorage.googleapis.com/v0/b/ride-share-a1e6e.appspot.com/o/profile_photos%2Fuser_img.png?alt=media&token=1ac398e6-0e34-417c-9cc6-652cae3b6e5b";

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
        profile: json["profile"] ??
            "https://firebasestorage.googleapis.com/v0/b/ride-share-a1e6e.appspot.com/o/profile_photos%2Fuser_img.png?alt=media&token=1ac398e6-0e34-417c-9cc6-652cae3b6e5b",
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
        "profile": profile,
      };
}
