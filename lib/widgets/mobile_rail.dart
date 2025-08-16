import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun_tv_demo/data/mock_rail_data.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/content_tile.dart';

class MobileContentRail extends StatelessWidget {
  final ContentRailData data;
  final ScrollController horizontalController;

  const MobileContentRail({
    super.key,
    required this.data,
    required this.horizontalController,
  });

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          sliver: SliverToBoxAdapter(
            child: Text(
              data.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 120,
            child: ListView.separated(
              controller: horizontalController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: data.items.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8.0),
              itemBuilder: (context, index) {
                final item = data.items[index];
                return ContentTile(item: item);
              },
            ),
          ),
        ),
      ],
    );
  }
}
