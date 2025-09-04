import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/app_colors.dart';
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
        color: AppColors.amber1,
        icon: Icons.info_outline,
        slideAssetPath: 'assets/slides/about/disclaimer.json',
      ),
      ContentItem(
        title: 'About',
        description: 'Lets meet the speaker',
        color: AppColors.emerald1,
        icon: Icons.speaker,
        slideAssetPath: 'assets/slides/about/about.json',
      ),
    ],
  ),
];
