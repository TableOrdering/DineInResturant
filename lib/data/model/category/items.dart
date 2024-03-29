import 'dart:convert';

import 'package:dine_in_resturant/data/model/category/category.dart';


class ItemsModel {
  final String? id;
  final String? name;
  final String? description;
  final int? price;
  final int? discount;
  final int? rating;
  final CategoryModel? category;
  final bool? isAvailable;
  final String? productImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ItemsModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.discount,
    this.rating,
    this.category,
    this.isAvailable,
    this.productImage,
    this.createdAt,
    this.updatedAt,
  });

  ItemsModel copyWith({
    String? id,
    String? name,
    String? description,
    int? price,
    int? discount,
    int? rating,
    CategoryModel? category,
    bool? isAvailable,
    String? productImage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ItemsModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        rating: rating ?? this.rating,
        category: category ?? this.category,
        isAvailable: isAvailable ?? this.isAvailable,
        productImage: productImage ?? this.productImage,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ItemsModel.fromRawJson(String str) =>
      ItemsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemsModel.fromJson(Map<String, dynamic> json) => ItemsModel(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        discount: json["discount"],
        rating: json["rating"],
        category: json["category"] == null
            ? null
            : CategoryModel.fromJson(json["category"]),
        isAvailable: json["isAvailable"],
        productImage: json["productImage"],
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
        "description": description,
        "price": price,
        "discount": discount,
        "rating": rating,
        "category": category?.toJson(),
        "isAvailable": isAvailable,
        "productImage": productImage,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
