import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 700;
    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 64,
        vertical: isMobile ? 70 : 120,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'THE EVERYDAY\nESSENTIAL.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 42 : 72,
                  height: 0.95,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -2,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Thoughtfully selected products for\nhow you live every day.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 17,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 36),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 18,
                  ),
                  shape: const RoundedRectangleBorder(),
                ),
                child: const Text(
                  'SHOP COLLECTION',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
