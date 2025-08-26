import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun_tv_demo/shortcuts/activate_secondary_intent.dart';
import 'package:flutter_focus_fun_tv_demo/shortcuts/long_press_activator.dart';

class KeyboardShortcuts {
  static Map<ShortcutActivator, Intent>? shortcuts() => {
    // Menu opening
    const SingleActivator(LogicalKeyboardKey.contextMenu): const MenuIntent(),

    // Long Press activation
    LongPressActivator([LogicalKeyboardKey.enter]):
        const ActivateSecondaryIntent(),

    // Dismissal
    const SingleActivator(LogicalKeyboardKey.escape): const DismissIntent(),
  }..addAll(WidgetsApp.defaultShortcuts);
}

class MenuIntent extends Intent {
  const MenuIntent();
}
