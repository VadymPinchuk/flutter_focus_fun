import 'package:flutter/material.dart';
import 'package:flutter_focus_fun/constants.dart';
import 'package:flutter_focus_fun/context_extensions.dart';
import 'package:flutter_focus_fun/data/content_item.dart';
import 'package:flutter_focus_fun/pages/detail_page.dart';
import 'package:flutter_focus_fun/widgets/content_tile.dart';

class TvTile extends StatefulWidget {
  final bool autofocus;
  final String index;
  final ContentItem item;
  final void Function(bool hasFocus) onFocusChange;

  const TvTile({
    super.key,
    this.autofocus = false,
    required this.index,
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
        return Actions(
          actions: {
            // Handling Actions based on Intent we want to support.
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (_) {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (_, _, _) => DetailPage(item: widget.item),
                    transitionsBuilder: (_, animation, _, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    transitionDuration: const Duration(milliseconds: 300),
                  ),
                );
                return null;
              },
            ),
          },
          child: Focus(
            autofocus: widget.autofocus,
            debugLabel: widget.item.title,
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
              duration: kAnimationDuration,
              // Conditionally apply the scale transform.
              transform:
                  Matrix4.identity()..scale(applyFocusEffects ? 1.2 : 1.0),
              transformAlignment: Alignment.center,
              // Conditionally apply the padding for the border.
              padding: EdgeInsets.all(applyFocusEffects ? 3.0 : 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                gradient:
                    applyFocusEffects
                        ? LinearGradient(
                          colors: [
                            context.colors.primary,
                            context.colors.secondary,
                            context.colors.inversePrimary,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                        : null,
              ),
              child: AnimatedOpacity(
                // When not focused, dim the tile only if decorations are enabled.
                // When focused, always show at full opacity.
                opacity: _isFocused ? 1.0 : (useDecoration ? 0.6 : 1.0),
                duration: kAnimationDuration,
                child: ContentTile(index: widget.index, item: widget.item),
              ),
            ),
          ),
        );
      },
    );
  }
}
