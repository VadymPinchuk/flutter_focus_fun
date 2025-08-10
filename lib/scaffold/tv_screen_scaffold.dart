import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TvScreenScaffold extends StatefulWidget {
  final Widget body;
  final Widget header;

  const TvScreenScaffold({super.key, required this.header, required this.body});

  @override
  State<TvScreenScaffold> createState() => _ScreenScaffoldState();
}

class _ScreenScaffoldState extends State<TvScreenScaffold> {
  late FocusScopeNode headerFocusNode;
  late FocusScopeNode bodyFocusNode;

  @override
  void initState() {
    headerFocusNode =
        FocusScopeNode(debugLabel: 'TvScreenScaffold Header FTS')
          ..skipTraversal = true
          ..descendantsAreFocusable = false;
    bodyFocusNode =
        FocusScopeNode(debugLabel: 'TvScreenScaffold Body FTS')
          ..skipTraversal = true
          ..descendantsAreFocusable = true;

    super.initState();
  }

  @override
  void dispose() {
    headerFocusNode.dispose();
    bodyFocusNode.dispose();
    super.dispose();
  }

  void _focusHeader() {
    bodyFocusNode.descendantsAreFocusable = false;
    headerFocusNode.descendantsAreFocusable = true;
    headerFocusNode.requestFocus();
  }

  void _focusBody() {
    bodyFocusNode.descendantsAreFocusable = true;
    headerFocusNode.descendantsAreFocusable = false;
    bodyFocusNode.requestFocus();
  }

  KeyEventResult _focusOnHeader(KeyEvent event) {
    if (event is! KeyUpEvent) return KeyEventResult.ignored;
    if (event.logicalKey == LogicalKeyboardKey.arrowUp &&
        bodyFocusNode.hasFocus) {
      _focusHeader();
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.f3 && bodyFocusNode.hasFocus) {
      _focusHeader();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FocusScope(
          node: bodyFocusNode,
          onKeyEvent: (node, event) {
            return _focusOnHeader(event);
          },
          child: widget.body,
        ),
        FocusScope(
          node: headerFocusNode,
          onKeyEvent: (node, event) {
            if (event is! KeyUpEvent) return KeyEventResult.ignored;
            if (event.logicalKey == LogicalKeyboardKey.arrowDown &&
                headerFocusNode.hasFocus) {
              _focusBody();
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: widget.header,
        ),
      ],
    );
  }
}

class _ScreenScaffoldScopePolicy extends ReadingOrderTraversalPolicy {
  final FocusScopeNode bodyNode;
  final FocusScopeNode headerNode;

  _ScreenScaffoldScopePolicy({
    required this.headerNode,
    required this.bodyNode,
  });

  @override
  bool inDirection(FocusNode traversalScope, TraversalDirection direction) {
    if (direction == TraversalDirection.up && bodyNode.hasFocus) {
      _focusHeader();
      return true;
    } else if (direction == TraversalDirection.down && headerNode.hasFocus) {
      _focusBody();
      return true;
    }
    return super.inDirection(traversalScope, direction);
  }

  void _focusHeader() {
    bodyNode.descendantsAreFocusable = false;
    headerNode.descendantsAreFocusable = true;
    headerNode.requestFocus();
  }

  void _focusBody() {
    bodyNode.descendantsAreFocusable = true;
    headerNode.descendantsAreFocusable = false;
    bodyNode.requestFocus();
  }
}
