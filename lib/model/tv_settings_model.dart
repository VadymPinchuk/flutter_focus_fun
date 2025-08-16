import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/utils/ui_experience.dart';

/// Defines the possible locations for the TV navigation bar.
enum TvNavBarLocation { top, left }

/// A model that holds the state for various TV-specific UI settings.
///
/// This uses ValueNotifiers to allow widgets to listen to and react to
/// changes for individual settings.
class TvSettingsModel {
  /// Determines if the app should use a side navigation rail (TV) or a
  /// bottom navigation bar (mobile).
  final ValueNotifier<UiExperience> _useTvLayout = ValueNotifier(
    UiExperience.mobile,
  );

  void toggleUiExperience() {
    _useTvLayout.value =
        _useTvLayout.value == UiExperience.mobile
            ? UiExperience.tv
            : UiExperience.mobile;
  }

  ValueNotifier<UiExperience> get uiExperience => _useTvLayout;

  /// Determines if arrow keys should be used for focus-based navigation.
  final ValueNotifier<bool> useFocusToNavigate = ValueNotifier(true);

  /// Determines if a visual decoration (e.g., a border or scale effect)
  /// should be shown on the currently focused item.
  final ValueNotifier<bool> useFocusDecoration = ValueNotifier(true);

  /// Determines if the page should use the "1.5 rail" TV layout with a
  /// large preview area at the top.
  final ValueNotifier<bool> useFixedRailViewport = ValueNotifier(true);

  /// Notifies listeners when the navigation bar location changes.
  final ValueNotifier<bool> useTopNavBar = ValueNotifier(false);

  /// Disposes the notifiers to prevent memory leaks.
  void dispose() {
    _useTvLayout.dispose();
    useFocusToNavigate.dispose();
    useFocusDecoration.dispose();
    useFixedRailViewport.dispose();
    useTopNavBar.dispose();
  }
}
