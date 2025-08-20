import 'package:flutter/widgets.dart';

class ContentItem {
  final String title;
  final String description;
  final Color color;
  final IconData icon;
  final String imagePath;
  final String slideAssetPath; // Path to the JSON slide file

  ContentItem({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
    this.imagePath = '',
    this.slideAssetPath = '', // Default to empty string
  });
}
