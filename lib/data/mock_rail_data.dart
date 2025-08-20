import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart'
    show ContentItem;
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class ContentRailData {
  final String id;
  final String title;
  final List<ContentItem> items;

  ContentRailData({required this.title, required this.items}) : id = _uuid.v4();
}

// Generates a large set of mock data for the UI.
final List<ContentRailData> mockData = [
  ContentRailData(
    title: 'The Focus System',
    items: [
      ContentItem(
        title: 'Focus Widget',
        description: 'The core of focusability.',
        color: Colors.blue.shade700,
        icon: Icons.center_focus_strong,
        slideAssetPath: 'assets/slides/focus_widget.json',
      ),
      ContentItem(
        title: 'FocusNode',
        description: 'The state of a focusable widget.',
        color: Colors.blue.shade800,
        icon: Icons.adjust,
        slideAssetPath: 'assets/slides/focus_node.json',
      ),
      ContentItem(
        title: 'FocusScope',
        description: 'Managing a group of FocusNodes.',
        color: Colors.blue.shade900,
        icon: Icons.select_all,
        slideAssetPath: 'assets/slides/focus_scope.md',
      ),
    ],
  ),
  ContentRailData(
    title: 'Traversal Policies',
    items: [
      ContentItem(
        title: 'ReadingOrderTraversalPolicy',
        description: 'The default navigation order.',
        color: Colors.green.shade700,
        icon: Icons.sort_by_alpha,
        slideAssetPath: 'assets/slides/reading_order_policy.md',
      ),
      ContentItem(
        title: 'FocusTraversalGroup',
        description: 'Defining navigation boundaries.',
        color: Colors.green.shade800,
        icon: Icons.group_work,
        slideAssetPath: 'assets/slides/focus_traversal_group.md',
      ),
      ContentItem(
        title: 'Custom Policies',
        description: 'Creating your own navigation rules.',
        color: Colors.green.shade900,
        icon: Icons.rule,
        slideAssetPath: 'assets/slides/custom_policies.md',
      ),
    ],
  ),
  // Add more rails and items as needed...
];

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
