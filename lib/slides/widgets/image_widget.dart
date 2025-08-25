import 'package:flutter/widgets.dart';

/// A widget that renders an image from an asset path.
class ImageWidget extends StatelessWidget {
  final String imagePath;

  const ImageWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      fit: BoxFit.contain,
      errorBuilder: (c, e, s) => const Placeholder(),
    );
  }
}
