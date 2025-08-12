import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart'
    show ContentItem;

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
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  color: widget.item.color,
                  child: Center(
                    child: Text(
                      widget.item.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(blurRadius: 2.0)],
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isFocused ? 0.0 : 0.5,
                  child: Container(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
