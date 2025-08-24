import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_rail_data.dart';

// Helper function to generate a list of icons for the tiles
List<IconData> _getTileIcons() {
  return [
    Icons.widgets_outlined,
    Icons.gesture,
    Icons.animation,
    Icons.style,
    Icons.layers,
    Icons.pages,
    Icons.navigation,
    Icons.input,
    Icons.settings_input_component,
    Icons.format_paint,
    Icons.code,
    Icons.build,
    Icons.developer_mode,
    Icons.memory,
    Icons.network_check,
    Icons.phone_android,
    Icons.tv,
    Icons.desktop_windows,
    Icons.web,
    Icons.bug_report,
    Icons.security,
    Icons.accessibility,
    Icons.group,
    Icons.cloud,
    Icons.storage,
    Icons.camera,
    Icons.music_note,
  ];
}

// Generates a large set of mock data for the UI.
final List<ContentRailData> mockHomeData = List.generate(20, (railIndex) {
  final colors = Colors.primaries;
  final icons = _getTileIcons();
  final railColor = colors[railIndex % colors.length];

  return ContentRailData(
    title: 'Rail Topic ${railIndex + 1}',
    items: List.generate(20, (tileIndex) {
      return ContentItem(
        title: 'Tile ${railIndex + 1}.${tileIndex + 1}',
        description: 'A dummy item description',
        color: railColor[(tileIndex % 9 + 1) * 100]!,
        icon: icons[tileIndex % icons.length],
        imagePath: '',
        slideAssetPath: '',
      );
    }),
  );
});
