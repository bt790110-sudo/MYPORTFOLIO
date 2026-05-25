import 'package:flutter/material.dart';

class SkillModel {
  final String name;
  final double percentage;
  final IconData icon;

  SkillModel({
    required this.name,
    required double percentage,
    required this.icon,
  }) : percentage = percentage.clamp(0, 100).toDouble();
}