import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';
import 'package:flutter_focus_fun_tv_demo/data/mock_rail_data.dart';

/// A view model (ChangeNotifier) to store and manage the scroll state
/// for a single page that contains vertical and horizontal lists.
class PageUiModel extends ChangeNotifier {
  final List<ContentRailData> railsData;

  PageUiModel(this.railsData);

  double _verticalOffset = 0.0;
  final Map<String, ScrollController> _horizontalControllers = {};
  final Map<String, double> _horizontalOffsets = {};

  /// Notifies listeners when the currently focused content item changes.
  final ValueNotifier<ContentItem?> focusedItem = ValueNotifier(null);

  /// Notifies listeners when the index of the focused rail changes.
  final ValueNotifier<int> focusedRailIndex = ValueNotifier(0);

  /// The last known vertical scroll offset.
  double get verticalOffset => _verticalOffset;

  /// Updates the stored vertical scroll offset.
  void setVerticalOffset(double offset) {
    _verticalOffset = offset;
    // No need to notify listeners, as the controller itself drives the UI.
  }

  /// Retrieves or creates a ScrollController for a horizontal rail with a given ID.
  ///
  /// This ensures that each rail gets a persistent controller that will
  /// remember its scroll position.
  ScrollController getHorizontalController(String railId) {
    if (!_horizontalControllers.containsKey(railId)) {
      // Create a new controller with the last known offset, or 0.0.
      final controller = ScrollController(
        initialScrollOffset: _horizontalOffsets[railId] ?? 0.0,
      );
      // Add a listener to save the offset whenever this rail is scrolled.
      controller.addListener(() {
        _horizontalOffsets[railId] = controller.offset;
      });
      _horizontalControllers[railId] = controller;
    }
    return _horizontalControllers[railId]!;
  }

  @override
  void dispose() {
    // Dispose of all created horizontal scroll controllers to prevent memory leaks.
    for (var controller in _horizontalControllers.values) {
      controller.dispose();
    }
    focusedItem.dispose();
    focusedRailIndex.dispose();
    super.dispose();
  }
}
