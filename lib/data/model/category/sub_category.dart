import 'dart:convert';

import 'package:dine_in/data/model/category/category.dart';

class SubCategory {
  final String? id;
  final String? name;
  final String? resturant;
  final CategoryModel? category;
  final String? subcategoryImage;
  final bool? isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SubCategory({
    this.id,
    this.name,
    this.resturant,
    this.category,
    this.subcategoryImage,
    this.isAvailable,
    this.createdAt,
    this.updatedAt,
  });

  SubCategory copyWith({
    String? id,
    String? name,
    String? resturant,
    CategoryModel? category,
    String? subcategoryImage,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      SubCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        resturant: resturant ?? this.resturant,
        category: category ?? this.category,
        subcategoryImage: subcategoryImage ?? this.subcategoryImage,
        isAvailable: isAvailable ?? this.isAvailable,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory SubCategory.fromRawJson(String str) =>
      SubCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["_id"],
        name: json["name"],
        resturant: json["resturant"],
        category: json["category"] == null
            ? null
            : CategoryModel.fromJson(json["category"]),
        subcategoryImage: json["subcategoryImage"],
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
        "resturant": resturant,
        "category": category?.toJson(),
        "subcategoryImage": subcategoryImage,
        "isAvailable": isAvailable,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
