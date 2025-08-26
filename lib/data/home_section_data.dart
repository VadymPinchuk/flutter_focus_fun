import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_rail_data.dart';

// Generates a large set of mock data for the UI.
final List<ContentRailData> mockHomeData = List.generate(20, (railIndex) {
  final colors = Colors.primaries;
  final railColor = colors[railIndex % colors.length];

  return ContentRailData(
    title: 'Rail Topic ${railIndex + 1}',
    items: List.generate(Random().nextInt(10) + 1, (tileIndex) {
      return ContentItem(
        title: 'Tile ${railIndex + 1}.${tileIndex + 1}',
        description: 'A dummy item description',
        color: railColor[(tileIndex % 9 + 1) * 100]!,
        imagePath: '',
        slideAssetPath: '',
      );
    }),
  );
});
