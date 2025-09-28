import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun/constants.dart';

/// A custom scroll controller that handles precise scrolling for a horizontal TV rail.
/// It accounts for list padding to ensure focused items are correctly positioned.
class TvRailScrollController {
  final ScrollController scrollController;
  final double tileWidth;
  final double tileSpacing;
  final double railPadding;

  TvRailScrollController({
    required this.scrollController,
    required this.tileWidth,
    required this.tileSpacing,
    required this.railPadding,
  });

  /// Scrolls the list to bring the item at the given index into view.
  void animateToIndex(int index) {
    // Calculate the target offset to center the tile, accounting for the left padding.
    final targetOffset = (index * (tileWidth + tileSpacing));
    scrollController.animateTo(
      targetOffset.clamp(0.0, scrollController.position.maxScrollExtent),
      duration: kAnimationDuration,
      curve: Curves.easeInOut,
    );
  }
}
