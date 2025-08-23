import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_rail_data.dart';

/// AboutPage data
final List<ContentRailData> aboutPageRails = [
  ContentRailData(
    title: 'About This App',
    items: [
      ContentItem(
        title: 'Disclaimer',
        description: 'Important notes about this project.',
        color: Colors.grey.shade800,
        icon: Icons.info_outline,
        slideAssetPath: 'assets/slides/about/disclaimer.json',
      ),
    ],
  ),
];
