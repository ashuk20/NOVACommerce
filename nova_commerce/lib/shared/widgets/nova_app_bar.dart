import 'package:flutter/material.dart';

class NovaAppBar extends StatelessWidget {
  const NovaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isDesktop = width >= 1100;
        final isTablet = width >= 700 && width < 1100;
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
                onPressed: () {},
                icon: const Icon(Icons.shopping_bag_outlined),
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
