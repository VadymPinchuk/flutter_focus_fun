import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';

/// Defines the possible locations for the TV navigation bar.
enum TvNavBarLocation { top, left }

/// A model that holds the UI state for the TV experience using ValueNotifiers.
class TvScreenModel {
  /// Notifies listeners when the navigation bar location changes.
  final ValueNotifier<TvNavBarLocation> navBarLocation = ValueNotifier(
    TvNavBarLocation.left,
  );

  /// Disposes the notifiers to prevent memory leaks.
  void dispose() {
    navBarLocation.dispose();
  }
}
