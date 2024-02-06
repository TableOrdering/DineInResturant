import 'dart:typed_data';

class CreateCategoryExtension {
  String name;
  String description;
  String foodType;
  bool isAvailable;
  Uint8List image;

  CreateCategoryExtension({
    required this.name,
    required this.description,
    required this.foodType,
    required this.isAvailable,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'foodType': foodType,
      'isAvailable': isAvailable,
      'categoryImage': image,
    };
  }
}
