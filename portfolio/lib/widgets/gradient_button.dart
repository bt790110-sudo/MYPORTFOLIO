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
    final button = ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null ? Icon(icon, size: 20) : const SizedBox.shrink(),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        backgroundColor: outlined ? Colors.transparent : null,
        foregroundColor: outlined ? gradient.colors.first : Colors.white,
        elevation: outlined ? 0 : 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: outlined
              ? BorderSide(color: gradient.colors.first, width: 2)
              : BorderSide.none,
        ),
      ),
    );
    
    if (outlined) {
      return button;
    }
    
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: button,
    );
  }
}