import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_rail_data.dart';

/// InfoSection data
final List<ContentRailData> infoSectionRails = [
  ContentRailData(
    title: '',
    items: [
      ContentItem(
        title: 'FFF',
        description: 'Intro',
        color: Colors.grey.shade800,
        slideAssetPath: 'assets/slides/info/0_intro.json',
      ),
      ContentItem(
        title: 'What Focus is for?',
        description: 'The key to building apps that work everywhere.',
        color: Colors.grey.shade800,
        slideAssetPath: 'assets/slides/info/1_why_care_about_focus.json',
      ),
      ContentItem(
        title: 'One Codebase',
        description: 'Structuring the app',
        color: Colors.grey.shade800,
        slideAssetPath: 'assets/slides/info/2_one_codebase_n_experiences.json',
      ),
    ],
  ),
];
