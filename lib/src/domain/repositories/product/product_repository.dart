import 'package:techtest/src/data/models/product_result_model.dart';

abstract class ProductRepository {
  Future<ProductResultModel?> getList();
}
