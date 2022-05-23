import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:techtest/src/core/constants/assets_constants.dart';
import 'package:techtest/src/domain/datasources/remote/product_service.dart';

class ProductServiceImpl implements ProductService {
  @override
  Future<Response> getList() async {
    try {
      String _jsonString =
          await rootBundle.loadString(AssetsConstants.productJson);
      final Map<String, dynamic> _jsonResult = json.decode(_jsonString);
      Map<String, dynamic> _data = _jsonResult;
      return Response(
        data: _data,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );
    } catch (e) {
      Map<String, dynamic> _data = {
        'message': 'failed load product data',
      };
      return Response(
        data: _data,
        statusCode: 401,
        requestOptions: RequestOptions(path: ''),
      );
    }
  }
}
