import 'package:flutter/material.dart';
import 'package:techtest/src/data/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  List<ProductModel> dataCart = [];
  double totalPrice = 0;
  String currency = '';

  void addCard({
    required ProductModel product,
  }) {
    dataCart.add(product);
    totalPrice += product.price;
    currency = product.currency;
    notifyListeners();
  }

  void removeCard({
    required ProductModel product,
  }) {
    dataCart.removeAt(
      dataCart.indexWhere((element) => element.id == product.id),
    );
    totalPrice -= product.price;
    currency = product.currency;
    notifyListeners();
  }
}
