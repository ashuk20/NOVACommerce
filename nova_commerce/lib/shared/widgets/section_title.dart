import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onAction;
  const SectionTitle({
    super.key,
    required this.title,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const Spacer(),
        if (actionText != null)
          TextButton(onPressed: onAction, child: Text(actionText!)),
      ],
    );
  }
}
