import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nova_commerce/core/network/api_client.dart';
import 'package:nova_commerce/features/products/models/product.dart';
import 'package:nova_commerce/features/products/services/product_service.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final ProductServiceProvider = Provider<ProductService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProductService(apiClient.dio);
});

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final service = ref.watch(ProductServiceProvider);
  return service.getProducts();
});
