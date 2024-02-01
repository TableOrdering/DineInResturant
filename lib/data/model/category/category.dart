import 'dart:convert';
import 'package:dine_in/data/model/category/resturant.dart';

class CategoryModel {
  final String? id;
  final String? name;
  final Restaurant? restaurant;
  final String? categoryImage;
  final String? foodType;
  final bool? isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CategoryModel({
    this.id,
    this.name,
    this.restaurant,
    this.categoryImage,
    this.foodType,
    this.isAvailable,
    this.createdAt,
    this.updatedAt,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    Restaurant? restaurant,
    String? categoryImage,
    String? foodType,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        restaurant: restaurant ?? this.restaurant,
        categoryImage: categoryImage ?? this.categoryImage,
        foodType: foodType ?? this.foodType,
        isAvailable: isAvailable ?? this.isAvailable,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        name: json["name"],
        restaurant: json["restaurant"] == null
            ? null
            : Restaurant.fromJson(json["restaurant"]),
        categoryImage: json["categoryImage"],
        foodType: json["foodType"],
        isAvailable: json["isAvailable"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "restaurant": restaurant?.toJson(),
        "categoryImage": categoryImage,
        "foodType": foodType,
        "isAvailable": isAvailable,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
