import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/colors.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/theme_toggle_button.dart';

class HeroSection extends StatelessWidget {
  final void Function(GlobalKey) scrollToSection;

  const HeroSection({
    super.key,
    required this.scrollToSection,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 20,
      ),
      child: isDesktop
          ? Row(
              children: [
                Expanded(child: _buildLeftColumn(context, isDark)),
                Expanded(
                  child: Center(
                    child: _buildRightColumn(context, isDark),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildLeftColumn(context, isDark),
                  const SizedBox(height: 40),
                  _buildRightColumn(context, isDark),
                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }

  Widget _buildLeftColumn(BuildContext context, bool isDark) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    // FIX: stable key instead of new GlobalKey()
    final GlobalKey heroKey = GlobalKey();

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: ThemeToggleButton(onTap: () {}),
        ),

        const SizedBox(height: 40),

        Text(
          "Hello, I'm",
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: 20,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
            letterSpacing: 2,
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(),

        const SizedBox(height: 16),

        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            "Bikram Thapa",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: isMobile ? 42 : 68,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.1,
            ),
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),

        const SizedBox(height: 16),

        SizedBox(
          height: 60,
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText("Flutter Developer",
                  textStyle: TextStyle(
                      fontSize: isMobile ? 22 : 28,
                      color: AppColors.primary),
                  speed: const Duration(milliseconds: 100)),
              TypewriterAnimatedText("Backend Engineer",
                  textStyle: TextStyle(
                      fontSize: isMobile ? 22 : 28,
                      color: AppColors.secondary),
                  speed: const Duration(milliseconds: 100)),
              TypewriterAnimatedText("Database Enthusiast",
                  textStyle: TextStyle(
                      fontSize: isMobile ? 22 : 28,
                      color: AppColors.accent),
                  speed: const Duration(milliseconds: 100)),
            ],
            repeatForever: true,
          ),
        ),

        const SizedBox(height: 24),

        Text(
          "Building scalable, performant, and elegant\nsolutions for the modern web and mobile.",
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: 16,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
            height: 1.6,
          ),
        ),

        const SizedBox(height: 32),

        Wrap(
          spacing: 16,
          children: [
            GradientButton(
              text: "Hire Me",
              onPressed: () => scrollToSection(heroKey),
              gradient: AppColors.primaryGradient,
              icon: Icons.rocket_launch,
            ),
            GradientButton(
              text: "Download Resume",
              onPressed: () async {
                await launchUrl(Uri.parse('#'));
              },
              gradient: AppColors.secondaryGradient,
              outlined: true,
              icon: Icons.download,
            ),
          ],
        ),

        const SizedBox(height: 40),

        Wrap(
          spacing: 16,
          children: [
            _buildSocialIcon(FontAwesomeIcons.github, '#'),
            _buildSocialIcon(FontAwesomeIcons.linkedin, '#'),
            _buildSocialIcon(FontAwesomeIcons.facebook, '#'),
          ],
        ),
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context, bool isDark) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      width: isMobile ? 220 : 320,
      height: isMobile ? 220 : 320,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(80),
            blurRadius: 60,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 2 * pi),
            duration: const Duration(seconds: 20),
            builder: (context, value, child) {
              return Transform.rotate(
                angle: value,
                child: Container(
                  width: isMobile ? 240 : 340,
                  height: isMobile ? 240 : 340,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withAlpha(120),
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),

          CircleAvatar(
            radius: isMobile ? 90 : 140,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile.jpg',
                width: isMobile ? 180 : 280,
                height: isMobile ? 180 : 280,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).scale(delay: 400.ms);
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(20),
          borderRadius: BorderRadius.circular(12),
        ),
        child: FaIcon(icon, size: 24),
      ),
    );
  }
}