import 'package:flutter/material.dart';  // ✅ ADD THIS IMPORT

class ServiceModel {
  final String title;
  final String description;
  final IconData icon;  // Now IconData is recognized
  
  ServiceModel({
    required this.title,
    required this.description,
    required this.icon,
  });
}