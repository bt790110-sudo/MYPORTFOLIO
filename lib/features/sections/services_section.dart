import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../widgets/section_header.dart';
import '../../widgets/service_card.dart';
import '../../models/service_model.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final services = [
      ServiceModel(
        title: 'Flutter App Development',
        description:
            'Cross-platform mobile apps with native performance and beautiful UI/UX designs.',
        icon: Icons.mobile_friendly,
      ),
      ServiceModel(
        title: 'Backend API Development',
        description:
            'Scalable REST APIs with FastAPI, Django, and Node.js for robust backend systems.',
        icon: Icons.api,
      ),
      ServiceModel(
        title: 'Database Design',
        description:
            'Efficient database architecture using PostgreSQL, MySQL, and Firebase.',
        icon: Icons.storage,
      ),
      ServiceModel(
        title: 'UI/UX Development',
        description:
            'Modern, responsive interfaces with smooth animations and interactions.',
        icon: Icons.design_services,
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 80,
      ),
      color: isDark ? Colors.transparent : const Color(0xFFF8F9FA),
      child: Column(
        children: [
          const SectionHeader(
            title: "Services",
            subtitle: "What I offer",
          ),
          const SizedBox(height: 48),

          // FIX: prevents Web overflow + layout rebuild issues
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              int crossAxisCount;

              if (width >= 1200) {
                crossAxisCount = 4;
              } else if (width >= 800) {
                crossAxisCount = 2;
              } else {
                crossAxisCount = 1;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return ServiceCard(service: services[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}