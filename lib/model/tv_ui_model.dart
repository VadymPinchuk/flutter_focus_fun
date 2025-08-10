import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';

/// Defines the possible locations for the TV navigation bar.
enum TvNavBarLocation { top, left }

/// A model that holds the UI state for the TV experience using ValueNotifiers.
class TvUiModel {
  /// Notifies listeners when the currently focused content item changes.
  final ValueNotifier<ContentItem?> focusedItem = ValueNotifier(null);

  /// Notifies listeners when the navigation bar location changes.
  final ValueNotifier<TvNavBarLocation> navBarLocation = ValueNotifier(
    TvNavBarLocation.top,
  );

  /// Notifies listeners when the index of the focused rail changes.
  final ValueNotifier<int> focusedRailIndex = ValueNotifier(0);

  /// Disposes the notifiers to prevent memory leaks.
  void dispose() {
    focusedItem.dispose();
    navBarLocation.dispose();
    focusedRailIndex.dispose();
  }
}
