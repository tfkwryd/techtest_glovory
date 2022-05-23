import 'dart:convert';

class ProductModel {
  ProductModel({
    required this.id,
    required this.productName,
    required this.productThumbnail,
    required this.category,
    required this.price,
    required this.currency,
  });

  int id;
  String productName;
  String productThumbnail;
  String category;
  double price;
  String currency;

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        productName: json["product_name"],
        productThumbnail: json["product_thumbnail"],
        category: json["category"],
        price: json["price"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "product_thumbnail": productThumbnail,
        "category": category,
        "price": price,
        "currency": currency,
      };
}
