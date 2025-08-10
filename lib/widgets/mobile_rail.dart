import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';
import 'package:flutter_focus_fun_tv_demo/data/mock_rail_data.dart';
import 'package:flutter_focus_fun_tv_demo/pages/mobile_detail_page.dart';

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
                return MobileContentTile(item: item);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MobileContentTile extends StatelessWidget {
  final ContentItem item;

  const MobileContentTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MobileDetailPage(item: item),
              ),
            );
          },
          // This Material widget ensures the InkWell can draw its ripple
          // and helps with hit detection.
          child: Material(
            color: item.color,
            child: Center(
              child: Text(
                item.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 2.0)],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
