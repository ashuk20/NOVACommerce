import 'package:flutter/material.dart';
import 'package:nova_commerce/features/products/models/product.dart';
import 'package:nova_commerce/features/products/screens/product_details_screen.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final isOutOfStock = product.stockQuantity <= 0;
    return MouseRegion(
      cursor: SystemMouseCursors.click,

      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(
              width: double.infinity,
              height: 280,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: product.imageUrl != null
                        ? Image.network(
                            product.imageUrl!,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            errorBuilder: (_, __, ___) {
                              return const _ImagePlaceholder();
                            },
                          )
                        : const _ImagePlaceholder(),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 19,
                        ),
                      ),
                    ),
                  ),
                  if (isOutOfStock)
                    Positioned(
                      left: 12,
                      bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        color: Colors.black,
                        child: Text(
                          'OUT OF STOCK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Text(
              product.categoryName.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              '₹${product.price.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.image_outlined, size: 42, color: Colors.black26),
    );
  }
}
