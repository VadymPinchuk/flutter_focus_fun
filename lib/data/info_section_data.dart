import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_rail_data.dart';

/// InfoSection data
final List<ContentRailData> infoSectionRails = [
  ContentRailData(
    title: 'Focus System Explained',
    items: [
      ContentItem(
        title: 'FFF',
        description: 'Intro',
        color: Colors.grey.shade800,
        slideAssetPath: 'assets/slides/info/0_intro.json',
      ),
      // ContentItem(
      //   title: 'Why do we need Focus?',
      //   description: 'The key to building apps that work everywhere.',
      //   color: Colors.grey.shade800,
      //   slideAssetPath: 'assets/slides/info/1_why_care_about_focus.json',
      // ),
      // ContentItem(
      //   title: 'FocusNode',
      //   description: 'The brain of a focusable Widget',
      //   color: Colors.grey.shade800,
      //   slideAssetPath: 'assets/slides/info/2_focus_node.json',
      // ),
    ],
  ),
];
