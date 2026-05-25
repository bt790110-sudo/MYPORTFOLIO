import 'package:flutter/material.dart';  // ✅ ADD THIS IMPORT

class SkillModel {
  final String name;
  final double percentage;
  final IconData icon;  // Now IconData is recognized
  
  SkillModel({
    required this.name,
    required this.percentage,
    required this.icon,
  });
}