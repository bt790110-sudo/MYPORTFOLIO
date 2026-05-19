import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentYear = DateTime.now().year;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 48,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF0A0A0A), const Color(0xFF1A1A1A)]
              : [const Color(0xFFF8F9FA), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          ),
        ),
      ),
      child: Column(
        children: [
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBrand(),
                _buildQuickLinks(),
                _buildSocialSection(),
              ],
            )
          else
            Column(
              children: [
                _buildBrand(),
                const SizedBox(height: 32),
                _buildQuickLinks(),
                const SizedBox(height: 32),
                _buildSocialSection(),
              ],
            ),
          const SizedBox(height: 32),
          Divider(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
          const SizedBox(height: 24),
          Text(
            '© $currentYear Bikram Thapa. Crafted with Flutter',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.grey[500] : Colors.grey[600],
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            AppStrings.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.title,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildQuickLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Links',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildLink('Home', '/'),
        _buildLink('About', '/about'),
        _buildLink('Projects', '/projects'),
        _buildLink('Contact', '/contact'),
      ],
    );
  }

  Widget _buildLink(String title, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          // FIX: prevents silent no-action bug
          debugPrint('Navigate to: $route');
        },
        child: Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildSocialSection() {
    return Column(
      children: [
        const Text(
          'Connect With Me',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildSocialIcon(FontAwesomeIcons.github,
                'https://github.com'),
            const SizedBox(width: 12),
            _buildSocialIcon(FontAwesomeIcons.linkedin,
                'https://linkedin.com'),
            const SizedBox(width: 12),
            _buildSocialIcon(FontAwesomeIcons.facebook,
                'https://facebook.com'),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);

        try {
          final launched = await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          );

          if (!launched) {
            debugPrint('Could not launch $url');
          }
        } catch (e) {
          debugPrint('Launch error: $e');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          shape: BoxShape.circle,
        ),
        child: FaIcon(icon, color: Colors.white, size: 16),
      ),
    );
  }
}