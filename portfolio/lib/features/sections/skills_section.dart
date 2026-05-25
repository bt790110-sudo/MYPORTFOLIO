import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../widgets/section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    final skills = [
      {'name': 'Flutter & Dart', 'icon': Icons.mobile_friendly},
      {'name': 'FastAPI', 'icon': Icons.api},
      {'name': 'Python', 'icon': Icons.code},
      {'name': 'MySQL', 'icon': Icons.storage},
      {'name': 'Supabase', 'icon': Icons.cloud},
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 80,
      ),
      child: Column(
        children: [
          const SectionHeader(
            title: "Technical Expertise",
            subtitle: "Skills & Technologies I Use",
          ),
          const SizedBox(height: 48),

          // FIX 1: LayoutBuilder passes distinct width constraints to the grid engine
          LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isDesktop ? 3 : (isTablet ? 2 : 1),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  // FIX 2: Dynamic aspect ratios keep cards from crashing on smaller screens
                  childAspectRatio: isDesktop ? 2.8 : (isTablet ? 3.2 : 4.0),
                ),
                itemCount: skills.length,
                itemBuilder: (context, index) {
                  final skill = skills[index];

                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          skill['icon'] as IconData,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        // FIX 3: Wrapped text elements with Flexible to stop pixel overflows 
                        Flexible(
                          child: Text(
                            skill['name'] as String,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  // FIX 4: Kept animations active but lightweight for seamless web draws
                  .animate()
                  .fadeIn(duration: 400.ms, delay: (index * 50).ms)
                  .slideY(begin: 0.1);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}