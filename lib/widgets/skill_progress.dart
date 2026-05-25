import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../models/skill_model.dart';

class SkillProgress extends StatelessWidget {
  final SkillModel skill;

  const SkillProgress({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // SAFE COLOR HANDLING (prevents null crashes)
    final borderColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final bgColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;

    // SAFE PROGRESS VALUE CLAMP
    final progress = skill.percentage.clamp(0, 100) / 100;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(skill.icon, color: AppColors.primary, size: 24),
              const SizedBox(width: 12),
              Text(
                skill.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '${skill.percentage.toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: borderColor,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}