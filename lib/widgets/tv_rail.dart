import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart'
    show ContentItem;
import 'package:flutter_focus_fun_tv_demo/data/mock_rail_data.dart'
    show ContentRailData;
import 'package:provider/provider.dart';

import '../model/tv_ui_model.dart';

class NoArrowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

class TvRail extends StatelessWidget {
  final ContentRailData data;
  final int railIndex;
  final ScrollController horizontalController;
  final bool isFirstRail;

  const TvRail({
    super.key,
    required this.data,
    required this.railIndex,
    required this.horizontalController,
    this.isFirstRail = false,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: context.read<TvUiModel>().focusedRailIndex,
      builder: (context, focusedRailIndex, child) {
        // A rail is visible if its index is the same as or after the focused rail.
        final bool isVisible = railIndex >= focusedRailIndex;
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: isVisible ? 1.0 : 0.0,
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Text(
                data.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 140,
              child: ScrollConfiguration(
                behavior: NoArrowScrollBehavior(),
                child: ValueListenableBuilder<TvNavBarLocation>(
                  valueListenable: context.read<TvUiModel>().navBarLocation,
                  builder: (_, location, __) {
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      controller: horizontalController,
                      clipBehavior: Clip.none,
                      padding: EdgeInsets.only(
                        left: location == TvNavBarLocation.left ? 116.0 : 48.0,
                        right: 48.0,
                      ),
                      itemCount: data.items.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 16.0),
                      itemBuilder: (_, index) {
                        final item = data.items[index];
                        return FocusableContentTile(
                          item: item,
                          railIndex: railIndex,
                          autofocus: isFirstRail && index == 0,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FocusableContentTile extends StatefulWidget {
  final ContentItem item;
  final int railIndex;
  final bool autofocus;

  const FocusableContentTile({
    super.key,
    required this.item,
    required this.railIndex,
    this.autofocus = false,
  });

  @override
  State<FocusableContentTile> createState() => _FocusableContentTileState();
}

class _FocusableContentTileState extends State<FocusableContentTile> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    // We use .read here because we are only writing to the model, not listening.
    final tvUiModel = context.read<TvUiModel>();

    return Focus(
      autofocus: widget.autofocus,
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
        if (hasFocus) {
          // When this tile gets focus, update both the item and the rail index.
          tvUiModel.focusedItem.value = widget.item;
          tvUiModel.focusedRailIndex.value = widget.railIndex;
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: 0.5,
          );
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
