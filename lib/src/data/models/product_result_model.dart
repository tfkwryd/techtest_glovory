import 'dart:convert';
import 'package:techtest/src/data/models/product_model.dart';

class ProductResultModel {
  ProductResultModel({
    required this.result,
  });

  List<ProductModel> result;

  factory ProductResultModel.fromRawJson(String str) =>
      ProductResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductResultModel.fromJson(Map<String, dynamic> json) =>
      ProductResultModel(
        result: List<ProductModel>.from(
            json["result"].map((x) => ProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}
