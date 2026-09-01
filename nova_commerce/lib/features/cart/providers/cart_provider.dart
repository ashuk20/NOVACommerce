import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nova_commerce/features/cart/models/cart_item.dart';
import 'package:nova_commerce/features/products/models/product.dart';

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    return [];
  }

  void addToCart(Product product, {int quantity = 1}) {
    final existingIndex = state.indexWhere(
      (item) => item.product.id == product.id,
    );
    if (existingIndex == -1) {
      final safeQuantity = quantity > product.stockQuantity
          ? product.stockQuantity
          : quantity;
      state = [...state, CartItem(product: product, quantity: safeQuantity)];
      print(
        'CART UPDATED: ${state.length} item(s), '
        '${state.first.product.name} x ${state.first.quantity}',
      );
      return;
    }

    final existingItem = state[existingIndex];
    final newQuantity = existingItem.quantity + quantity;

    if (newQuantity > product.stockQuantity) {
      return;
    }

    final updatedItem = existingItem.copyWith(quantity: newQuantity);
    final updatedCart = [...state];
    updatedCart[existingIndex] = updatedItem;

    state = updatedCart;
  }

  void increaseQuantity(int productId) {
    final index = state.indexWhere((item) => item.product.id == productId);

    if (index == -1) return;

    final item = state[index];

    if (item.quantity >= item.product.stockQuantity) {
      return;
    }

    final updatedCart = [...state];

    updatedCart[index] = item.copyWith(quantity: item.quantity + 1);
    state = updatedCart;
  }

  void decreaseQuantity(int productId) {
    final index = state.indexWhere((item) => item.product.id == productId);

    if (index == -1) return;
    final item = state[index];

    if (item.quantity <= 1) {
      removeFromCart(productId);
      return;
    }

    final updatedCart = [...state];
    updatedCart[index] = item.copyWith(quantity: item.quantity - 1);

    state = updatedCart;
  }

  void removeFromCart(int productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  double get subtotal {
    return state.fold(0, (total, item) => total + item.totalPrice);
  }

  int get itemCount {
    return state.fold(0, (total, item) => total + item.quantity);
  }

  void clearCart() {
    state = [];
  }
}

final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);
