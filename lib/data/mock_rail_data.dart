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

// Generates some mock data for the UI.
final List<ContentRailData> mockData = [
  ContentRailData(
    title: 'Introduction',
    items: List.generate(
      10,
      (index) => ContentItem(
        title: 'Intro ${index + 1}',
        description:
            'An engaging look at the core concepts of building for TV.',
        color: Colors.red.shade400,
        imagePath: 'assets/intro_bg.jpg',
      ),
    ),
  ),
  ContentRailData(
    title: 'The 10-Foot UI Paradigm',
    items: List.generate(
      10,
      (index) => ContentItem(
        title: 'Paradigm ${index + 1}',
        description:
            'Learn the design principles of interfaces controlled from a distance.',
        color: Colors.green.shade400,
        imagePath: 'assets/paradigm_bg.jpg',
      ),
    ),
  ),
  ContentRailData(
    title: "Flutter's Focus System",
    items: List.generate(
      10,
      (index) => ContentItem(
        title: 'Focus ${index + 1}',
        description:
            'A deep dive into FocusNode, FocusScope, and the widget tree.',
        color: Colors.blue.shade400,
        imagePath: 'assets/focus_bg.jpg',
      ),
    ),
  ),
  ContentRailData(
    title: 'Directing the Flow',
    items: List.generate(
      10,
      (index) => ContentItem(
        title: 'Flow ${index + 1}',
        description:
            'Mastering focus traversal to create intuitive navigation.',
        color: Colors.orange.shade400,
        imagePath: 'assets/flow_bg.jpg',
      ),
    ),
  ),
  ContentRailData(
    title: 'Actions & Polish',
    items: List.generate(
      10,
      (index) => ContentItem(
        title: 'Polish ${index + 1}',
        description:
            'Bringing your app to life with animations, sounds, and shortcuts.',
        color: Colors.purple.shade400,
        imagePath: 'assets/polish_bg.jpg',
      ),
    ),
  ),
];

// Generates some mock data for the UI.
final List<ContentRailData> mockConfData = [
  ContentRailData(
    title: '#ftcon25in',
    items: [
      ContentItem(
        title: 'FlutterCon India Keynote',
        description:
            'Join us for the opening keynote of FlutterCon India 2025.',
        color: Colors.amber.shade700,
        imagePath: 'assets/india/0_in.jpeg',
      ),
    ],
  ),
  ContentRailData(
    title: '#ftcon25eu',
    items: List.generate(
      10,
      (index) => ContentItem(
        title: 'EU Session ${index + 1}',
        description:
            'A deep dive into Flutter development from our European conference.',
        color: Colors.blue.shade700,
        imagePath: 'assets/eu/${index}_eu.jpeg',
      ),
    ),
  ),
  ContentRailData(
    title: '#ftcon25usa',
    items: List.generate(
      44,
      (index) => ContentItem(
        title: 'USA Workshop ${index + 1}',
        description: 'Hands-on workshops from our USA conference series.',
        color: Colors.red.shade700,
        imagePath: 'assets/usa/${index}_usa.jpeg',
      ),
    ),
  ),
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
final List<ContentRailData> mockHomeData = List.generate(25, (railIndex) {
  final colors = Colors.primaries;
  final icons = _getTileIcons();
  final railColor = colors[railIndex % colors.length];

  return ContentRailData(
    title: 'Rail Topic ${railIndex + 1}',
    items: List.generate(25, (tileIndex) {
      return ContentItem(
        title: 'Tile ${railIndex + 1}.${tileIndex + 1}',
        description: 'A dummy item description',
        color: railColor[(tileIndex % 9 + 1) * 100]!,
        icon: icons[tileIndex % icons.length],
        imagePath: '',
      );
    }),
  );
});
