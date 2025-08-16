import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/utils/ui_experience.dart';

/// Defines the possible locations for the TV navigation bar.
enum TvNavBarLocation { top, left }

/// A model that holds the state for various TV-specific UI settings.
///
/// This uses ValueNotifiers to allow widgets to listen to and react to
/// changes for individual settings.
class SettingsModel {
  /// Determines if the app should use a side navigation rail (TV) or a
  /// bottom navigation bar (mobile).
  final ValueNotifier<UiExperience> uiExperience = ValueNotifier(
    UiExperience.tv,
  );

  void toggleUiExperience() {
    uiExperience.value =
        uiExperience.value.isMobile ? UiExperience.tv : UiExperience.mobile;
  }

  /// Determines if a visual decoration (e.g., a border or scale effect)
  /// should be shown on the currently focused item.
  final ValueNotifier<bool> useFocusDecoration = ValueNotifier(false);

  void toggleFocusDecoration() {
    useFocusDecoration.value = !useFocusDecoration.value;
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

  /// Shows additional menu with rails about me and my information.
  final ValueNotifier<bool> showAboutPage = ValueNotifier(false);

  void toggleAboutPageVisibility() {
    showAboutPage.value = !showAboutPage.value;
  }

  /// Disposes the notifiers to prevent memory leaks.
  void dispose() {
    uiExperience.dispose();
    useFocusDecoration.dispose();
    useTvPageLayout.dispose();
    useCustomTraversalPolicy.dispose();
    showAboutPage.dispose();
  }
}
