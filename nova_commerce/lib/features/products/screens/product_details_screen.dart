import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nova_commerce/features/products/models/product.dart';

import 'package:nova_commerce/features/cart/providers/cart_provider.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  int quantity = 1;
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final isOutOfStock = product.stockQuantity <= 0;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          'NOVA',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 3),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 700;
                  if (isMobile) {
                    return _MobileLayout(
                      product: product,
                      quantity: quantity,
                      isFavorite: isFavorite,
                      isOutOfStock: isOutOfStock,
                      onFavorite: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      onQuantityChanged: (value) {
                        setState(() {
                          quantity = value;
                        });
                      },
                      onAddToCart: () {
                        ref
                            .read(cartProvider.notifier)
                            .addToCart(product, quantity: quantity);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to cart')),
                        );
                      },
                    );
                  }
                  return _DesktopLayout(
                    product: product,
                    quantity: quantity,
                    isFavorite: isFavorite,
                    isOutOfStock: isOutOfStock,
                    onFavorite: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    onQuantityChanged: (value) {
                      setState(() {
                        quantity = value;
                      });
                    },
                    onAddToCart: () {
                      ref
                          .read(cartProvider.notifier)
                          .addToCart(product, quantity: quantity);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added to cart')),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final Product product;
  final int quantity;
  final bool isFavorite;
  final bool isOutOfStock;
  final VoidCallback onFavorite;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onAddToCart;
  const _DesktopLayout({
    required this.product,
    required this.quantity,
    required this.isFavorite,
    required this.isOutOfStock,
    required this.onFavorite,
    required this.onQuantityChanged,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: _ProductImage(
            product: product,
            isOutOfStock: isOutOfStock,
            isFavorite: isFavorite,
            onFavorite: onFavorite,
          ),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 4,
          child: _ProductInformation(
            product: product,
            quantity: quantity,
            isOutOfStock: isOutOfStock,
            onQuantityChanged: onQuantityChanged,
            onAddToCart: onAddToCart,
          ),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final Product product;
  final int quantity;
  final bool isFavorite;
  final bool isOutOfStock;
  final VoidCallback onFavorite;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onAddToCart;
  const _MobileLayout({
    required this.product,
    required this.quantity,
    required this.isFavorite,
    required this.isOutOfStock,
    required this.onFavorite,
    required this.onQuantityChanged,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProductImage(
          product: product,
          isOutOfStock: isOutOfStock,
          isFavorite: isFavorite,
          onFavorite: onFavorite,
        ),
        const SizedBox(height: 32),
        _ProductInformation(
          product: product,
          quantity: quantity,
          isOutOfStock: isOutOfStock,
          onQuantityChanged: onQuantityChanged,
          onAddToCart: onAddToCart,
        ),
      ],
    );
  }
}

class _ProductImage extends StatelessWidget {
  final Product product;
  final bool isOutOfStock;
  final bool isFavorite;
  final VoidCallback onFavorite;
  const _ProductImage({
    required this.product,
    required this.isOutOfStock,
    required this.isFavorite,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F1),
              borderRadius: BorderRadius.circular(4),
            ),
            clipBehavior: Clip.antiAlias,
            child: product.imageUrl != null
                ? Image.network(
                    product.imageUrl!,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) {
                      return const Icon(
                        Icons.image_outlined,
                        size: 60,
                        color: Colors.black26,
                      );
                    },
                  )
                : const Icon(
                    Icons.image_outlined,
                    size: 60,
                    color: Colors.black26,
                  ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: onFavorite,
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              ),
            ),
          ),
          if (isOutOfStock)
            Positioned(
              left: 16,
              bottom: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                color: Colors.black,
                child: const Text(
                  'OUT OF STOCK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ProductInformation extends StatelessWidget {
  final Product product;
  final int quantity;
  final bool isOutOfStock;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onAddToCart;

  const _ProductInformation({
    required this.product,
    required this.quantity,
    required this.isOutOfStock,
    required this.onQuantityChanged,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.categoryName.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            letterSpacing: 1.5,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 36,
            height: 1.1,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '₹${product.price.toStringAsFixed(0)}',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 28),
        const Divider(),
        const SizedBox(height: 28),
        Text(
          product.description ?? '',
          style: const TextStyle(
            fontSize: 15,
            height: 1.7,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 28),
        Row(
          children: [
            Icon(
              isOutOfStock ? Icons.cancel_outlined : Icons.check_circle_outline,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              isOutOfStock
                  ? 'Out of Stock'
                  : '${product.stockQuantity} available',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 28),
        if (!isOutOfStock) ...[
          const Text(
            'QUANTITY',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1.3,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          _QuantitySelector(
            quantity: quantity,
            maxQuantity: product.stockQuantity,
            onChanged: onQuantityChanged,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: onAddToCart,
              child: Text(
                'ADD TO CART',
                style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  final int quantity;
  final int maxQuantity;
  final ValueChanged<int> onChanged;

  const _QuantitySelector({
    required this.quantity,
    required this.maxQuantity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD5D5D5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: quantity > 1 ? () => onChanged(quantity - 1) : null,
            icon: const Icon(Icons.remove, size: 18),
          ),
          SizedBox(
            width: 40,
            child: Center(
              child: Text(
                '$quantity',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          IconButton(
            onPressed: quantity < maxQuantity
                ? () => onChanged(quantity + 1)
                : null,
            icon: const Icon(Icons.add, size: 18),
          ),
        ],
      ),
    );
  }
}
