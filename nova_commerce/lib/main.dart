import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nova_commerce/features/home/screens/home_screen.dart';
import 'package:nova_commerce/features/products/screens/products_screen.dart';

void main() {
  runApp(const ProviderScope(child: NovaCommerceApp()));
}

class NovaCommerceApp extends StatelessWidget {
  const NovaCommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NOVA Commerce',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
