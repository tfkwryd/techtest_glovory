import 'package:flutter/material.dart';
import 'package:techtest/src/core/utils/toast_utils.dart';
import 'package:techtest/src/data/datasource/remote/product_service_impl.dart';
import 'package:techtest/src/data/models/product_model.dart';
import 'package:techtest/src/data/repositories/product/product_repository_impl.dart';
import 'package:techtest/src/domain/repositories/product/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository _productRepository = ProductRepositoryImpl(
    service: ProductServiceImpl(),
  );
  var isLoading = false;
  var dataSource = <ProductModel>[];
  var categorySource = <String>[];
  var dataProduct = <ProductModel>[];
  var activeKeyword = '';
  var isActiveSearch = false;

  Future<void> getList() async {
    isLoading = true;
    notifyListeners();
    try {
      await _productRepository.getList().then((value) {
        if (value != null) {
          dataSource.addAll(value.result);
          // ignore: avoid_function_literals_in_foreach_calls
          value.result.forEach((e) {
            if (!categorySource.contains(e.category)) {
              categorySource.add(e.category);
            }
          });
        }
      });
    } catch (e) {
      Toast.show(message: e.toString(), toastType: ToastType.error);
    }
    dataProduct = dataSource;
    isLoading = false;
    notifyListeners();
  }

  Future<void> search({
    String? keyword,
    bool isSearch = false,
  }) async {
    try {
      if (keyword != null && keyword != '') {
        dataProduct = dataSource.where((element) {
          return element.productName
                  .toLowerCase()
                  .contains(keyword.toLowerCase()) ||
              element.category.toLowerCase().contains(keyword.toLowerCase());
        }).toList();
        activeKeyword = keyword;
      } else {
        dataProduct = dataSource;
        activeKeyword = '';
      }
      isActiveSearch = isSearch;
    } catch (e) {
      Toast.show(message: e.toString(), toastType: ToastType.error);
    }
    notifyListeners();
  }
}
