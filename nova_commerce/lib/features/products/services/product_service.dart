import 'package:dio/dio.dart';
import 'package:nova_commerce/core/constants/api_constants.dart';
import 'package:nova_commerce/features/products/models/product.dart';

class ProductService {
  final Dio _dio;

  ProductService(this._dio);

  Future<List<Product>> getProducts() async {
    final response = await _dio.get('${ApiConstants.baseUrl}/Products');

    final data = response.data as List;

    return data.map((json) => Product.fromJson(json)).toList();
  }
}
