import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart'
    show ContentItem;

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
