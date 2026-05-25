import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  // Safe wrapper for URL launching across desktop and web environments
  Future<void> _handleLaunchUrl(BuildContext context, String urlString) async {
    final uri = Uri.parse(urlString);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open $urlString'),
            backgroundColor: Colors.red.shade600,
          ),
        );
      }
    }
  }

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
            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: isDesktop ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBrand(),
                _buildQuickLinks(),
                _buildSocialSection(context),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBrand(),
                const SizedBox(height: 32),
                _buildQuickLinks(),
                const SizedBox(height: 32),
                _buildSocialSection(context),
              ],
            ),
          const SizedBox(height: 32),
          Divider(color: isDark ? Colors.grey[800] : Colors.grey[200]),
          const SizedBox(height: 24),
          
          // Centered copyright block for unified desktop/mobile look
          Align(
            alignment: Alignment.center,
            child: Text(
              '© $currentYear Bikram Thapa. Crafted with Flutter',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[500] : Colors.grey[600],
                letterSpacing: 0.5,
              ),
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
          shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
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
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
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
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: () {
            // TODO: Connect to your App Router navigation context here
          },
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              title,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Connect With Me',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSocialIcon(context, FontAwesomeIcons.github, 'https://github.com'),
            const SizedBox(width: 12),
            _buildSocialIcon(context, FontAwesomeIcons.linkedin, 'https://linkedin.com'),
            const SizedBox(width: 12),
            _buildSocialIcon(context, FontAwesomeIcons.facebook, 'https://facebook.com'),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(BuildContext context, IconData icon, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () => _handleLaunchUrl(context, url),
        customBorder: const CircleBorder(),
        child: Container(
          padding: const EdgeInsets.all(10), // Boosted hit-target area padding
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            shape: BoxShape.circle,
          ),
          child: FaIcon(icon, color: Colors.white, size: 16),
        ),
      ),
    );
  }
}