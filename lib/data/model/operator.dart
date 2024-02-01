import 'dart:convert';

class ResturantOperator {
  final String? id;
  final String? name;
  final String? description;
  final String? address;
  final String? resturantImage;
  final int? contact;
  final String? userType;
  final String? token;

  const ResturantOperator({
    this.id,
    this.name,
    this.description,
    this.address,
    this.resturantImage,
    this.contact,
    this.userType,
    this.token,
  });

  ResturantOperator copyWith({
    String? id,
    String? name,
    String? description,
    String? address,
    String? resturantImage,
    int? contact,
    String? userType,
    String? token,
  }) =>
      ResturantOperator(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        address: address ?? this.address,
        resturantImage: resturantImage ?? this.resturantImage,
        contact: contact ?? this.contact,
        userType: userType ?? this.userType,
        token: token ?? this.token,
      );

  factory ResturantOperator.fromRawJson(String str) =>
      ResturantOperator.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResturantOperator.fromJson(Map<String, dynamic> json) =>
      ResturantOperator(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        address: json["address"],
        resturantImage: json["resturantImage"],
        contact: json["contact"],
        userType: json["userType"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "address": address,
        "resturantImage": resturantImage,
        "contact": contact,
        "userType": userType,
        "token": token,
      };
}
