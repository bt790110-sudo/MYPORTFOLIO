import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../widgets/section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

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

          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              int crossAxisCount;
              if (width >= 1000) {
                crossAxisCount = 3;
              } else {
                crossAxisCount = 2;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 2.8,
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
                        Text(
                          skill['name'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(
                        duration: 400.ms,
                        delay: (index * 100).ms,
                      )
                      .slideY(begin: 0.2);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}