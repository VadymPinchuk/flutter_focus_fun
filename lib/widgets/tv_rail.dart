import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_rail_data.dart';
import 'package:flutter_focus_fun_tv_demo/scroll/tv_rail_scroll_controller.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/tv_tile.dart';


class TvRail extends StatelessWidget {
  final ContentRailData data;
  final int railIndex;
  final TvRailScrollController railScrollController;
  final void Function(int tileIndex) onFocusChange;

  const TvRail({
    super.key,
    required this.data,
    required this.railIndex,
    required this.railScrollController,
    required this.onFocusChange,
  });

  @override
  Widget build(BuildContext context) {
    final railData = context.railData;
    return ValueListenableBuilder(
      valueListenable: context.settingsModel.useTvFixedFocusController,
      builder: (_, isFixedFocusUsed, _) {
        return SizedBox(
          height: railData.railFullHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: railData.railVerticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: railData.titleHeight,
                  padding: EdgeInsets.symmetric(
                    horizontal: railScrollController.railPadding,
                  ),
                  child: Text(
                    data.title,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: railData.railTitleSpacing),
                SizedBox(
                  height: railData.tileSize.height,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    controller: railScrollController.scrollController,
                    clipBehavior: Clip.none,
                    padding: EdgeInsets.symmetric(
                      horizontal: railScrollController.railPadding,
                    ),
                    itemCount: data.items.length,
                    separatorBuilder:
                        (_, _) => SizedBox(width: railData.tilesSpacing),
                    itemBuilder: (_, index) {
                      final item = data.items[index];
                      return TvTile(
                        index: "${railIndex + 1}.${index + 1}",
                        item: item,
                        autofocus: railIndex == 0 && index == 0,
                        onFocusChange: (hasFocus) {
                          if (isFixedFocusUsed && hasFocus) {
                            railScrollController.animateToIndex(index);
                            onFocusChange(index);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
