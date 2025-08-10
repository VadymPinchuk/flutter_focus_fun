import 'dart:ui';

class ContentItem {
  final String title;
  final String description;
  final Color color;
  final String imagePath; // For background

  ContentItem({
    required this.title,
    required this.description,
    required this.color,
    required this.imagePath,
  });
}
