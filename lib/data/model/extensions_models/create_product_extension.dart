import 'dart:typed_data';

class CreateItemExtension {
  String? name;
  String? description;
  int? price;
  int? discount;
  int? rating;
  String? category;
  bool? isAvailable;
  Uint8List? productImage;

  CreateItemExtension({
    this.name,
    this.description,
    this.price,
    this.discount,
    this.rating,
    this.category,
    this.isAvailable,
    this.productImage,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "discount": discount,
      "rating": rating,
      "category": category,
      "isAvailable": isAvailable,
      "productImage": productImage,
    };
  }
}
