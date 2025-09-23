import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/utils/user_experience.dart';

/// Defines the possible locations for the TV navigation bar.
enum TvNavBarLocation { top, left }

/// A model that holds the state for various TV-specific UI settings.
///
/// This uses ValueNotifiers to allow widgets to listen to and react to
/// changes for individual settings.
class SettingsModel {
  /// Determines if the app should use a side navigation rail (TV) or a
  /// bottom navigation bar (mobile).
  final ValueNotifier<UserExperience> experience = ValueNotifier(
    UserExperience.mobile,
  );

  void toggleUiExperience() {
    experience.value =
        experience.value.isMobile ? UserExperience.tv : UserExperience.mobile;
  }

  /// Determines if a custom focus traversal policy should be used
  final ValueNotifier<bool> useLightTheme = ValueNotifier(true);

  void toggleThemeSwitch() {
    useLightTheme.value = !useLightTheme.value;
  }

  /// Determines if a visual decoration (e.g., a border or scale effect)
  /// should be shown on the currently focused item.
  final ValueNotifier<bool> useFocusDecoration = ValueNotifier(false);

  void toggleFocusDecoration() {
    useFocusDecoration.value = !useFocusDecoration.value;
  }

  /// Determines if rail has a fixed focus or it is scrolled as usual.
  final ValueNotifier<bool> useTvFixedFocusController = ValueNotifier(false);

  void toggleTvFixedFocus() {
    useTvFixedFocusController.value = !useTvFixedFocusController.value;
  }

  /// Determines if arrow keys should be used for focus-based navigation.
  final ValueNotifier<bool> useTvPageLayout = ValueNotifier(false);

  void toggleTvPageLayout() {
    useTvPageLayout.value = !useTvPageLayout.value;
  }

  /// Determines if a custom focus traversal policy should be used
  final ValueNotifier<bool> useCustomTraversalPolicy = ValueNotifier(false);

  void toggleTraversalPolicy() {
    useCustomTraversalPolicy.value = !useCustomTraversalPolicy.value;
  }

  /// Controls the global text scaling factor for the entire application.
  final ValueNotifier<double> textScaleFactor = ValueNotifier(1.0);

  /// Controls the number of tiles displayed per row in content grids.
  final ValueNotifier<double> tilesPerRowCount = ValueNotifier(2.0);

  /// Disposes the notifiers to prevent memory leaks.
  void dispose() {
    experience.dispose();
    useFocusDecoration.dispose();
    useTvFixedFocusController.dispose();
    useTvPageLayout.dispose();
    useCustomTraversalPolicy.dispose();
    textScaleFactor.dispose();
    tilesPerRowCount.dispose();
  }
}
