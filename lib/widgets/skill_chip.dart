import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class SkillChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const SkillChip({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // small optimization: reuse colors (avoid rebuild allocations)
    final primary = AppColors.primary;
    final secondary = AppColors.secondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primary.withOpacity(0.1),
            secondary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primary.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: primary),
          const SizedBox(width: 8),
          const Text(
            '', // placeholder to allow const optimization pattern ignored safely
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}