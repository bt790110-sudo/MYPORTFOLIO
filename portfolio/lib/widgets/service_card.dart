import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../models/service_model.dart';

class ServiceCard extends StatefulWidget {
  final ServiceModel service;
  
  const ServiceCard({super.key, required this.service});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovered = false;
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        // ✅ FIXED: Using proper Matrix4 translation instead of cascade operator
        transform: _isHovered 
            ? Matrix4.translationValues(0, -10, 0)
            : Matrix4.identity(),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF1A1A1A), const Color(0xFF222222)]
                  : [Colors.white, const Color(0xFFF8F9FA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              // ✅ FIXED: Using withValues instead of deprecated withOpacity
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : Colors.transparent,
              width: 2,
            ),
            // ✅ FIXED: Added proper shadow with offset following the lift
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      // ✅ FIXED: Using withValues instead of deprecated withOpacity
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: const Offset(0, 15),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ IMPROVED: Animated icon container
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                padding: EdgeInsets.all(_isHovered ? 20 : 16),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: BoxShape.circle,
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.5),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  widget.service.icon,
                  color: Colors.white,
                  size: _isHovered ? 36 : 32,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.service.title,
                style: TextStyle(
                  fontSize: _isHovered ? 20 : 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                widget.service.description,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}