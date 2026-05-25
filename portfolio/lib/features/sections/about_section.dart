import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 80,
      ),
      color: isDark ? Colors.transparent : const Color(0xFFF8F9FA),
      child: Column(
        children: [
          const SectionHeader(
            title: "About Me",
            subtitle: "Get to know me better",
          ),
          const SizedBox(height: 48),
          _buildAboutContent(context),
        ],
      ),
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Professional Biography",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.aboutText,
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: isDark ? Colors.grey[300] : Colors.grey[700],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Career Objective",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          // FIX: Using GoogleFonts inline injector with clean fallback chains.
          // This allows you to style individual text elements italicized or colored 
          // without locking up Flutter Web's CanvasKit pipeline.
          Text(
            AppStrings.objective,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}