import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart'
    show ContentItem;
import 'package:flutter_focus_fun_tv_demo/widgets/content_tile.dart';

class TvTile extends StatefulWidget {
  final ContentItem item;
  final bool autofocus;
  final void Function(bool hasFocus) onFocusChange;

  const TvTile({
    super.key,
    required this.item,
    this.autofocus = false,
    required this.onFocusChange,
  });

  @override
  State<TvTile> createState() => _TvTileState();
}

class _TvTileState extends State<TvTile> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
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
        transform: Matrix4.identity()..scale(_isFocused ? 1.1 : 1.0),
        transformAlignment: Alignment.center,
        padding: EdgeInsets.all(_isFocused ? 3.0 : 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.0),
          gradient:
              _isFocused
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
        child: ContentTile(item: widget.item),
      ),
    );
  }
}
