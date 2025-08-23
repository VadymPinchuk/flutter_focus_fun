import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/constants.dart';
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
    return ValueListenableBuilder(
      valueListenable: context.settingsModel.useTvFixedFocusController,
      builder: (_, isFixedFocusUsed, _) {
        return SizedBox(
          height: kFullRailHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kRailPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: kTitleHeight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: railScrollController.railPadding,
                    ),
                    child: Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: kRailTitlePadding),
                SizedBox(
                  height: kRailHeight,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    controller: railScrollController.scrollController,
                    clipBehavior: Clip.none,
                    padding: EdgeInsets.symmetric(
                      horizontal: railScrollController.railPadding,
                    ),
                    itemCount: data.items.length,
                    separatorBuilder:
                        (_, _) =>
                            SizedBox(width: railScrollController.tileSpacing),
                    itemBuilder: (_, index) {
                      final item = data.items[index];
                      return TvTile(
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
