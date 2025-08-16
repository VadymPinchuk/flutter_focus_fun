
import 'package:flutter/widgets.dart';

class ContentItem {
  final String title;
  final String description;
  final Color color;
  final IconData? icon;
  final String imagePath; // For background

  ContentItem({
    required this.title,
    required this.description,
    required this.color,
    this.icon,
    required this.imagePath,
  });
}
