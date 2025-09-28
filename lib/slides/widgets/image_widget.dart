import 'package:flutter/material.dart';

/// A widget that renders an image from an asset path.
class ImageWidget extends StatelessWidget {
  final String imagePath;
  final bool useDarkVersion;

  const ImageWidget({super.key, required this.imagePath, required this.useDarkVersion});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final invertColors = useDarkVersion && theme.brightness == Brightness.light;
    return invertColors
        ? _InvertedImageWidget(imagePath: imagePath, fit: BoxFit.contain)
        : Image.asset(
          imagePath,
          fit: BoxFit.contain,
          errorBuilder: (c, e, s) => const Placeholder(),
        );
  }
}

/// A widget that displays an image with its colors programmatically inverted.
class _InvertedImageWidget extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const _InvertedImageWidget({required this.imagePath, this.width, this.height, this.fit});

  @override
  Widget build(BuildContext context) {
    // This is the 5x5 matrix that inverts the colors of an image.
    // It works by applying the formula: NewColor = 255 - OldColor
    // for each of the Red, Green, and Blue channels.
    // The alpha (transparency) channel is left unchanged.
    const List<double> invertMatrix = [
      // R  G  B  A  Const
      -1, 0, 0, 0, 255, // Red channel
      0, -1, 0, 0, 255, // Green channel
      0, 0, -1, 0, 255, // Blue channel
      0, 0, 0, 1, 0, // Alpha channel
    ];

    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(invertMatrix),
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        // It's good practice to include an error builder for asset images.
        errorBuilder: (c, e, s) => const Placeholder(),
      ),
    );
  }
}
