import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart'
    show ContentItem;
import 'package:flutter_focus_fun_tv_demo/widgets/content_tile.dart';

class TvTile extends StatefulWidget {
  final bool autofocus;
  final ContentItem item;
  final void Function(bool hasFocus) onFocusChange;

  const TvTile({
    super.key,
    this.autofocus = false,
    required this.item,
    required this.onFocusChange,
  });

  @override
  State<TvTile> createState() => _TvTileState();
}

class _TvTileState extends State<TvTile> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: context.settingsModel.useFocusDecoration,
      builder: (context, useDecoration, child) {
        final bool applyFocusEffects = useDecoration && _isFocused;
        return Focus(
          autofocus: widget.autofocus,
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
            });
            widget.onFocusChange(hasFocus);
            if (hasFocus) {
              context.pageUiModel.focusedItem.value = widget.item;
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            // Conditionally apply the scale transform.
            transform: Matrix4.identity()..scale(applyFocusEffects ? 1.1 : 1.0),
            transformAlignment: Alignment.center,
            // Conditionally apply the padding for the border.
            padding: EdgeInsets.all(applyFocusEffects ? 3.0 : 0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              // Conditionally apply the gradient border.
              gradient:
                  applyFocusEffects
                      ? const LinearGradient(
                        colors: [
                          Colors.cyanAccent,
                          Colors.pinkAccent,
                          Colors.yellowAccent,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                      : null,
            ),
            child: AnimatedOpacity(
              // When not focused, dim the tile only if decorations are enabled.
              // When focused, always show at full opacity.
              opacity: _isFocused ? 1.0 : (useDecoration ? 0.75 : 1.0),
              duration: const Duration(milliseconds: 200),
              child: ContentTile(item: widget.item),
            ),
          ),
        );
      },
    );
  }
}
