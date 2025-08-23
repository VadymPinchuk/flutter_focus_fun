import 'dart:ui';

/// Internal calculation helper with separate simple functions
class TileMeasureHelper {
  static double calculateTileWidth({
    required double itemsPerRow,
    required double screenWidth,
    required double tileSpacing,
    required double horizontalMargin,
  }) {
    if (itemsPerRow <= 0 || itemsPerRow >= screenWidth) return 0;
    if (screenWidth <= 0 || screenWidth == double.infinity) return 0;

    final rowWidthNoMargin = screenWidth - horizontalMargin * 2;
    final spacersCount = itemsPerRow - 1;
    final tilesOnlyWidth = rowWidthNoMargin - tileSpacing * spacersCount;
    if (tilesOnlyWidth <= 0) return 0;

    return tilesOnlyWidth / itemsPerRow;
  }

  static Size getTileSize(double width, double aspectRatio) {
    final height = width / aspectRatio;
    return Size(width, height);
  }
}
