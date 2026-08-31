import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nova_commerce/core/constants/api_constants.dart';
import 'package:nova_commerce/features/products/models/product.dart';
import 'package:nova_commerce/features/products/services/product_service.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late final ProductService _productService;

  List<Product> _products = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productService = ProductService(
      Dio(BaseOptions(baseUrl: ApiConstants.baseUrl)),
    );

    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _productService.getProducts();
      if (!mounted) return;

      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_error != null) {
      return Scaffold(body: Center(child: Text("Error: $_error")));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('NOVA')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text(product.categoryName),
            trailing: Text('₹${product.price.toStringAsFixed(2)}'),
          );
        },
        itemCount: _products.length,
      ),
    );
  }
}
