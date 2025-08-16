import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/mock_rail_data.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/body_widget.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: railScrollController.railPadding,
            ),
            child: Text(
              data.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              controller: railScrollController.scrollController,
              clipBehavior: Clip.none,
              padding: EdgeInsets.symmetric(
                horizontal: railScrollController.railPadding,
              ),
              itemCount: data.items.length,
              separatorBuilder:
                  (_, __) =>
                      SizedBox(width: railScrollController.tileSpacing),
              itemBuilder: (_, index) {
                final item = data.items[index];
                return TvTile(
                  item: item,
                  autofocus: railIndex == 0 && index == 0,
                  onFocusChange: (hasFocus) {
                    if (hasFocus) {
                      railScrollController.scrollToIndex(index);
                      onFocusChange(index);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
