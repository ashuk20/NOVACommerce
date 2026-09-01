import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nova_commerce/features/cart/providers/cart_provider.dart';
import 'package:nova_commerce/features/cart/screens/cart_screen.dart';

class NovaAppBar extends ConsumerWidget {
  const NovaAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final itemCount = ref.watch(cartProvider.notifier).itemCount;
    final cart = ref.watch(cartProvider);
    final itemCount = cart.fold<int>(0, (total, item) => total + item.quantity);
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isDesktop = width >= 1100;
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 32 : 20,
            vertical: 18,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Color(0xFFEAEAEA))),
          ),
          child: Row(
            children: [
              const Text(
                'NOVA',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),

              if (isDesktop) ...[
                const SizedBox(width: 50),
                _NavItem(label: 'Shop', onTap: () {}),
                _NavItem(label: 'New Arrivals', onTap: () {}),
                _NavItem(label: 'Collections', onTap: () {}),
              ],

              const Spacer(),

              IconButton(
                tooltip: 'Search',
                onPressed: () {},
                icon: const Icon(Icons.search_outlined),
              ),
              IconButton(
                tooltip: 'Wishlist',
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
              ),
              IconButton(
                tooltip: 'Cart',
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const CartScreen()));
                },
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.shopping_bag_outlined),
                    if (itemCount > 0)
                      Positioned(
                        right: -8,
                        top: -8,
                        child: Container(
                          constraints: const BoxConstraints(
                            minWidth: 17,
                            minHeight: 17,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            itemCount > 99 ? '99+' : '$itemCount',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              if (isDesktop) ...[
                const SizedBox(width: 8),
                OutlinedButton(onPressed: () {}, child: const Text('SING IN')),
              ],
              if (!isDesktop) ...[
                const SizedBox(width: 4),
                IconButton(
                  onPressed: () {},
                  tooltip: 'Menu',
                  icon: const Icon(Icons.menu),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _NavItem({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 28.0),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
