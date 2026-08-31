import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nova_commerce/features/home/widgets/hero_section.dart';
import 'package:nova_commerce/features/products/providers/product_provider.dart';
import 'package:nova_commerce/shared/widgets/nova_app_bar.dart';
import 'package:nova_commerce/shared/widgets/product_card.dart';
import 'package:nova_commerce/shared/widgets/section_title.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: NovaAppBar()),
          const SliverToBoxAdapter(child: HeroSection()),
          SliverToBoxAdapter(child: _CategoriesSection()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 60, 32, 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: const SectionTitle(
                    title: 'Featured Products',
                    actionText: 'View all',
                  ),
                ),
              ),
            ),
          ),
          productsAsync.when(
            data: (product) {
              if (product.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(100),
                    child: Center(child: Text('No Products available.')),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ProductCard(product: product[index]);
                  }, childCount: product.length),
                  gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 280,
                        mainAxisExtent: 390,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 32,
                      ),
                ),
              );
            },
            error: (_, __) => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(100),
                child: Text('Unable to load products.'),
              ),
            ),
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(100),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 32,
          runSpacing: 12,
          children: [
            _CategoryItem(label: 'ALL', selected: true),
            _CategoryItem(label: 'SNEAKERS'),
            _CategoryItem(label: 'CLOTHING'),
            _CategoryItem(label: 'CLOTHING'),
            _CategoryItem(label: 'ACCESSORIES'),
          ],
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String label;
  final bool selected;
  const _CategoryItem({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 12,
        letterSpacing: 1.2,
        fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
        // decoration: selected?TextDirection.underline:null
        decorationThickness: 2,
      ),
    );
  }
}
