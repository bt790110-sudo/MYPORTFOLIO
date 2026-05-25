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
                Expanded(
                  child: _buildLeftColumn(context, isDark),
                ),
                Expanded(
                  child: Center(
                    child: _buildRightColumn(context, isDark),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: ThemeToggleButton(
            onTap: () {},
          ),
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
              color: isDark ? Colors.white : Colors.black,
              height: 1.1,
            ),
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),

        const SizedBox(height: 16),

        // FIX 1: Removed external parent .animate() pipeline to let 
        // AnimatedTextKit handle layout engine updates unhindered on the web.
        SizedBox(
          height: 60,
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                "Flutter Developer",
                textStyle: TextStyle(
                  fontSize: isMobile ? 22 : 28,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                "Backend Engineer",
                textStyle: TextStyle(
                  fontSize: isMobile ? 22 : 28,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary,
                ),
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                "Database Enthusiast",
                textStyle: TextStyle(
                  fontSize: isMobile ? 22 : 28,
                  fontWeight: FontWeight.w500,
                  color: AppColors.accent,
                ),
                speed: const Duration(milliseconds: 100),
              ),
            ],
            repeatForever: true,
            pause: const Duration(milliseconds: 1000),
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
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideX(),

        const SizedBox(height: 32),

        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: [
            GradientButton(
              text: "Hire Me",
              onPressed: () => scrollToSection(GlobalKey()),
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
        ).animate().fadeIn(duration: 600.ms, delay: 400.ms).scale(),

        const SizedBox(height: 40),

        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildSocialIcon(FontAwesomeIcons.github, '#'),
            _buildSocialIcon(FontAwesomeIcons.linkedin, '#'),
            _buildSocialIcon(FontAwesomeIcons.facebook, '#'),
          ],
        ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
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
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 60,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // FIX 2: Replaced custom TweenAnimationBuilder loop with 
          // flutter_animate infinite rotation handling to eliminate web engine loop lag.
          Container(
            width: isMobile ? 240 : 340,
            height: isMobile ? 240 : 340,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withOpacity(0.5),
                width: 2,
              ),
            ),
          ).animate(onPlay: (controller) => controller.repeat())
           .rotate(duration: 20.seconds, begin: 0, end: 1),

          CircleAvatar(
            radius: isMobile ? 90 : 140,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile.jpg',
                width: isMobile ? 180 : 280,
                height: isMobile ? 180 : 280,
                fit: BoxFit.cover,
                // Soft rendering fallback to protect layout cycle
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 80),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).scale(delay: 400.ms);
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () async => await launchUrl(Uri.parse(url)),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: FaIcon(icon, size: 24),
      ),
    );
  }
}