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
        color: Colors.teal.shade400,
        slideAssetPath: 'assets/slides/info/1_setting_the_stage/1_intro.json',
      ),
      ContentItem(
        title: 'What Focus is for?',
        description: 'The key to building apps that work everywhere.',
        color: Colors.teal.shade500,
        slideAssetPath:
            'assets/slides/info/1_setting_the_stage/2_why_care.json',
      ),
      ContentItem(
        title: 'One Codebase',
        description: 'Serving both mobile and TV UIs.',
        color: Colors.teal.shade600,
        slideAssetPath:
            'assets/slides/info/1_setting_the_stage/3_one_codebase.json',
      ),
      ContentItem(
        title: 'Responsive Theming',
        description: 'Managing styles for different view distances.',
        color: Colors.teal.shade700,
        slideAssetPath: 'assets/slides/info/1_setting_the_stage/4_theming.json',
      ),
      ContentItem(
        title: 'Rethinking Navigation',
        description: 'Why a Bottom Nav Bar fails on TV.',
        color: Colors.teal.shade800,
        slideAssetPath:
            'assets/slides/info/1_setting_the_stage/5_navigation.json',
      ),
      ContentItem(
        title: 'The "10-Foot Experience"',
        description: 'What it is and why it changes everything.',
        color: Colors.teal.shade900,
        slideAssetPath:
            'assets/slides/info/1_setting_the_stage/6_ten_foot.json',
      ),
    ],
  ),
];
