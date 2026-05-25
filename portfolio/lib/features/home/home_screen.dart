import 'package:flutter/material.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/skills_section.dart';
import '../sections/services_section.dart';
import '../sections/contact_section.dart';
import '../sections/footer_section.dart';
import '../../widgets/back_to_top_button.dart';
import '../../widgets/floating_particles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose(); 
    super.dispose();
  }

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // FIX 1: RepaintBoundary isolates the heavy particle animation 
          // keeping it from crashing the web rendering engine during scroll events
          const RepaintBoundary(
            child: FloatingParticles(),
          ),
          
          // Main Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(
                  key: _heroKey,
                  scrollToSection: scrollToSection,
                ),
                AboutSection(key: _aboutKey),
                SkillsSection(key: _skillsKey),
                ServicesSection(key: _servicesKey),
                ContactSection(key: _contactKey),
                const FooterSection(),
              ],
            ),
          ),
          
          // Back to Top Button
          BackToTopButton(controller: _scrollController),
        ],
      ),
    );
  }
}