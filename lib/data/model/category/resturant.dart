import 'dart:convert';

class Restaurant {
    final String? id;
    final String? name;
    final String? description;
    final String? address;
    final String? resturantImage;
    final int? contact;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Restaurant({
        this.id,
        this.name,
        this.description,
        this.address,
        this.resturantImage,
        this.contact,
        this.createdAt,
        this.updatedAt,
    });

    Restaurant copyWith({
        String? id,
        String? name,
        String? description,
        String? address,
        String? resturantImage,
        int? contact,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Restaurant(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            address: address ?? this.address,
            resturantImage: resturantImage ?? this.resturantImage,
            contact: contact ?? this.contact,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Restaurant.fromRawJson(String str) => Restaurant.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        address: json["address"],
        resturantImage: json["resturantImage"],
        contact: json["contact"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "address": address,
        "resturantImage": resturantImage,
        "contact": contact,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
