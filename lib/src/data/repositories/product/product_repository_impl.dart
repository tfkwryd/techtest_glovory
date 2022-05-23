import 'package:techtest/src/data/models/product_result_model.dart';
import 'package:techtest/src/domain/datasources/remote/product_service.dart';
import 'package:techtest/src/domain/repositories/product/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductService service;
  const ProductRepositoryImpl({required this.service});
  @override
  Future<ProductResultModel?> getList() async {
    try {
      var response = await service.getList();
      if (response.statusCode == 200) {
        return ProductResultModel.fromJson(response.data);
      } else {
        throw 'Request Failed -  ${response.statusCode}';
      }
    } catch (_) {
      rethrow;
    }
  }
}
