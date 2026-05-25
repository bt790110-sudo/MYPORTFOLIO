import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final LinearGradient gradient;
  final bool outlined;
  final IconData? icon;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.gradient,
    this.outlined = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final primary = gradient.colors.first;

    final child = ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null
          ? Icon(icon, size: 20)
          : const SizedBox(), // safer than shrink in rebuild-heavy UI
      label: Text(text),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        backgroundColor: outlined ? Colors.transparent : primary,
        foregroundColor: outlined ? primary : Colors.white,
        elevation: outlined ? 0 : 4,
        shadowColor: primary.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: outlined
              ? BorderSide(color: primary, width: 2)
              : BorderSide.none,
        ),
      ),
    );

    // MAJOR FIX: avoid double painting + web render issues
    if (outlined) {
      return child;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}