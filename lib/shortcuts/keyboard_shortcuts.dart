import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun_tv_demo/shortcuts/activate_secondary_intent.dart';
import 'package:flutter_focus_fun_tv_demo/shortcuts/add_intent.dart';
import 'package:flutter_focus_fun_tv_demo/shortcuts/long_press_activator.dart';
import 'package:flutter_focus_fun_tv_demo/shortcuts/single_click_activator.dart';
import 'package:flutter_focus_fun_tv_demo/utils/ui_experience.dart';

class KeyboardShortcuts {
  final UiExperience uiExperience;

  const KeyboardShortcuts({required this.uiExperience});

  Map<ShortcutActivator, Intent>? shortcuts() => switch (uiExperience) {
    UiExperience.tv => {
      // Activation
      SingleClickActivator([
            LogicalKeyboardKey.enter,
            LogicalKeyboardKey.numpadEnter,
            LogicalKeyboardKey.space,
          ]):
          const ActivateIntent(),

      // Long Press activation
      LongPressActivator([LogicalKeyboardKey.enter]):
          const ActivateSecondaryIntent(),

      // Dismissal
      const SingleActivator(LogicalKeyboardKey.escape): const DismissIntent(),

      // Playlist (+)
      const SingleActivator(LogicalKeyboardKey.f16): const AddIntent(),

      // Keyboard traversal
      const SingleActivator(LogicalKeyboardKey.tab): const NextFocusIntent(),
      const SingleActivator(LogicalKeyboardKey.tab, shift: true):
          const PreviousFocusIntent(),
      const SingleActivator(
        LogicalKeyboardKey.arrowLeft,
      ): const DirectionalFocusIntent(TraversalDirection.left),
      const SingleActivator(
        LogicalKeyboardKey.arrowRight,
      ): const DirectionalFocusIntent(TraversalDirection.right),
      const SingleActivator(
        LogicalKeyboardKey.arrowDown,
      ): const DirectionalFocusIntent(TraversalDirection.down),
      const SingleActivator(
        LogicalKeyboardKey.arrowUp,
      ): const DirectionalFocusIntent(TraversalDirection.up),
    },
    _ => null,
  };
}
