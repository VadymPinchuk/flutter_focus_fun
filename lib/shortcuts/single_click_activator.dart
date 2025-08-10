import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class SingleClickActivator extends ShortcutActivator {
  final Iterable<LogicalKeyboardKey> logicalKeys;

  SingleClickActivator(this.logicalKeys);

  KeyEvent? _previousKeyEvent;

  @override
  Iterable<LogicalKeyboardKey> get triggers => logicalKeys;

  @override
  bool accepts(KeyEvent event, HardwareKeyboard state) {
    final bool isDownAndUp = _previousKeyEvent is KeyDownEvent && event is KeyUpEvent;
    final bool isSameKey = _previousKeyEvent != null && _previousKeyEvent?.logicalKey == event.logicalKey;
    final bool isTriggerKey = triggers.contains(event.logicalKey);

    _previousKeyEvent = event;
    return isDownAndUp && isSameKey && isTriggerKey;
  }

  @override
  String debugDescribeKeys() => 'SingleClickEnterActivator';
}
