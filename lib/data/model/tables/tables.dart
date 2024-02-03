import 'dart:convert';

class TableModel {
  final String? id;
  final String? name;
  final int? tableNumber;
  final int? capacity;
  final bool? status;
  final String? resturant;
  final String? qrCodeData;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TableModel({
    this.id,
    this.name,
    this.tableNumber,
    this.capacity,
    this.status,
    this.resturant,
    this.qrCodeData,
    this.createdAt,
    this.updatedAt,
  });

  TableModel copyWith({
    String? id,
    String? name,
    int? tableNumber,
    int? capacity,
    bool? status,
    String? resturant,
    String? qrCodeData,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      TableModel(
        id: id ?? this.id,
        name: name ?? this.name,
        tableNumber: tableNumber ?? this.tableNumber,
        capacity: capacity ?? this.capacity,
        status: status ?? this.status,
        resturant: resturant ?? this.resturant,
        qrCodeData: qrCodeData ?? this.qrCodeData,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory TableModel.fromRawJson(String str) =>
      TableModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        id: json["_id"],
        name: json["name"],
        tableNumber: json["tableNumber"],
        capacity: json["capacity"],
        status: json["status"],
        resturant: json["resturant"],
        qrCodeData: json["qrCodeData"],
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
        "tableNumber": tableNumber,
        "capacity": capacity,
        "status": status,
        "resturant": resturant,
        "qrCodeData": qrCodeData,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
