import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class LongPressActivator extends ShortcutActivator {
  final Iterable<LogicalKeyboardKey> logicalKeys;

  LongPressActivator(this.logicalKeys);

  KeyEvent? _previousKeyEvent;

  @override
  Iterable<LogicalKeyboardKey> get triggers => logicalKeys;

  @override
  bool accepts(KeyEvent event, HardwareKeyboard state) {
    final bool isDownAndRepeat = _previousKeyEvent is KeyDownEvent && event is KeyRepeatEvent;
    final bool isSameKey = _previousKeyEvent != null && _previousKeyEvent?.logicalKey == event.logicalKey;
    final bool isTriggerKey = triggers.contains(event.logicalKey);

    _previousKeyEvent = event;
    return isDownAndRepeat && isSameKey && isTriggerKey;
  }

  @override
  String debugDescribeKeys() => 'LongPressActivator';
}
