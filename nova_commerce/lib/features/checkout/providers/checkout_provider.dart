import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:nova_commerce/core/constants/api_constants.dart';
import 'package:nova_commerce/features/checkout/models/create_order_request.dart';

final checkoutProvider = NotifierProvider<CheckOutNotifier, AsyncValue<void>>(
  CheckOutNotifier.new,
);

class CheckOutNotifier extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  Future<Map<String, dynamic>> createOrder(CreateOrderRequest request) async {
    state = const AsyncLoading();
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/Orders'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        state = const AsyncData(null);
        return data;
      }
      String message = 'Unable to create order.';

      try {
        final decode = jsonDecode(response.body);
        if (decode is String) {
          message = decode;
        } else if (decode is Map<String, dynamic>) {
          message =
              decode['message']?.toString() ??
              decode['title']?.toString() ??
              message;
        }
      } catch (_) {}
      throw Exception(message);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      rethrow;
    }
  }
}
