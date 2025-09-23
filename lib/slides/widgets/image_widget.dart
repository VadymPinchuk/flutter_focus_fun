import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/theme/background_reverse_gradient_theme.dart';
import 'package:flutter_focus_fun_tv_demo/theme/beige_theme.dart';

/// A widget that renders an image from an asset path.
class ImageWidget extends StatelessWidget {
  final String imagePath;

  const ImageWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade800,
      padding: EdgeInsets.all(16.0),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
        errorBuilder: (c, e, s) => const Placeholder(),
      ),
    );
  }
}

extension on BuildContext {
  List<Color>? get backGradient =>
      Theme.of(this).extension<BackgroundReverseGradientTheme>()?.colors;
}
