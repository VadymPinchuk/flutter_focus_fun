import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/app_colors.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_rail_data.dart';

/// InfoSection data
final List<ContentRailData> infoSectionRails = [
  _firstRail,
  _secondRail,
  _thirdRail,
  _fourthRail,
  _fifthRail,
];

final ContentRailData _firstRail = ContentRailData(
  title: 'Setting the Stage',
  items: [
    ContentItem(
      title: 'FFF',
      description: 'Intro',
      color: AppColors.indigo1,
      slideAssetPath: 'assets/slides/info/1_setting_the_stage/1_intro.json',
    ),
    ContentItem(
      title: 'What Focus is for?',
      description: 'The key to building apps that work everywhere.',
      color: AppColors.indigo2,
      slideAssetPath: 'assets/slides/info/1_setting_the_stage/2_why_care.json',
    ),
    ContentItem(
      title: 'One Codebase',
      description: 'Serving both mobile and TV UIs.',
      color: AppColors.indigo3,
      slideAssetPath:
          'assets/slides/info/1_setting_the_stage/3_one_codebase.json',
    ),
    ContentItem(
      title: 'Responsive Theming',
      description: 'Managing styles for different view distances.',
      color: AppColors.indigo4,
      slideAssetPath: 'assets/slides/info/1_setting_the_stage/4_theming.json',
    ),
    ContentItem(
      title: 'Rethinking Navigation',
      description: 'Why a Bottom Nav Bar fails on TV.',
      color: AppColors.indigo5,
      slideAssetPath:
          'assets/slides/info/1_setting_the_stage/5_navigation.json',
    ),
    ContentItem(
      title: 'The "10-Foot Experience"',
      description: 'What it is and why it changes everything.',
      color: AppColors.indigo6,
      slideAssetPath: 'assets/slides/info/1_setting_the_stage/6_ten_foot.json',
    ),
  ],
);

final ContentRailData _secondRail = ContentRailData(
  title: 'Core Components',
  items: [
    ContentItem(
      title: 'The Core Components',
      description: 'The fundamental building blocks for focus.',
      color: AppColors.ruby1,
      slideAssetPath: 'assets/slides/info/2_core_components/1_intro.json',
    ),
    ContentItem(
      title: 'The Atom',
      description: 'The brain of a focusable widget.',
      color: AppColors.ruby2,
      slideAssetPath: 'assets/slides/info/2_core_components/2_focus_node.json',
    ),
    ContentItem(
      title: 'The Workhorse',
      description: 'Bringing a FocusNode to the Widget Tree.',
      color: AppColors.ruby3,
      slideAssetPath:
          'assets/slides/info/2_core_components/3_focus_widget.json',
    ),
    ContentItem(
      title: 'Visualizing Focus',
      description: 'Providing clear visual feedback for the active element.',
      color: AppColors.ruby4,
      slideAssetPath:
          'assets/slides/info/2_core_components/4_visualizing_focus.json',
    ),
    ContentItem(
      title: 'Input Response',
      description: 'How to make your focused widget react to key presses.',
      color: AppColors.ruby5,
      slideAssetPath:
          'assets/slides/info/2_core_components/5_responding_to_input.json',
    ),
    ContentItem(
      title: 'KeyboardListener',
      description: 'For when you need direct access to raw key presses.',
      color: AppColors.ruby6,
      slideAssetPath:
          'assets/slides/info/2_core_components/6_keyboard_listener.json',
    ),
    ContentItem(
      title: 'Actions & Intents',
      description: 'Decoupling what the user wants from how it\'s done.',
      color: AppColors.ruby7,
      slideAssetPath:
          'assets/slides/info/2_core_components/7_actions_intents.json',
    ),
    ContentItem(
      title: 'Shortcuts',
      description: 'Actions and Intents in Action ><',
      color: AppColors.ruby8,
      slideAssetPath: 'assets/slides/info/2_core_components/8_shortcuts.json',
    ),
    ContentItem(
      title: 'CallbackShortcuts',
      description: 'Using built-in widgets for common keyboard actions.',
      color: AppColors.ruby9,
      slideAssetPath:
          'assets/slides/info/2_core_components/9_callback_shortcuts.json',
    ),
    ContentItem(
      title: 'The All-in-One: FocusableActionDetector',
      description: 'Your new best friend for interactive components.',
      color: AppColors.ruby10,
      slideAssetPath:
          'assets/slides/info/2_core_components/10_focusable_action_detector.json',
    ),
  ],
);

final ContentRailData _thirdRail = ContentRailData(
  title: 'Focus Management',
  items: [
    ContentItem(
      title: 'The Big Picture',
      description: 'Understanding the high-level architecture.',
      color: AppColors.emerald1,
      slideAssetPath: 'assets/slides/info/3_big_picture/1_intro.json',
    ),
    ContentItem(
      title: 'The Focus Tree',
      description: 'How Flutter organizes all focusable widgets.',
      color: AppColors.emerald2,
      slideAssetPath: 'assets/slides/info/3_big_picture/2_focus_tree.json',
    ),
    ContentItem(
      title: 'Debugging Focus',
      description: 'Using `debugDumpFocusTree()` to visualize your focus tree.',
      color: AppColors.emerald3,
      slideAssetPath: 'assets/slides/info/3_big_picture/3_debugging_focus.json',
    ),
    ContentItem(
      title: 'FocusManager',
      description: 'The singleton that orchestrates the entire focus system.',
      color: AppColors.emerald4,
      slideAssetPath: 'assets/slides/info/3_big_picture/4_focus_manager.json',
    ),
    ContentItem(
      title: 'Boss in Action',
      description: 'Key methods for interacting with the focus tree.',
      color: AppColors.emerald5,
      slideAssetPath:
          'assets/slides/info/3_big_picture/5_focus_manager_methods.json',
    ),
    ContentItem(
      title: 'You think you know focus?',
      description: 'Are you sure?',
      color: AppColors.emerald6,
      slideAssetPath: 'assets/slides/info/3_big_picture/6_joke.json',
    ),
  ],
);

final ContentRailData _fourthRail = ContentRailData(
  title: 'Traversal Control',
  items: [
    ContentItem(
      title: 'Traversal Control',
      description: 'Controlling the user\'s navigation path through the app.',
      color: AppColors.amber1,
      slideAssetPath: 'assets/slides/info/4_traversal/1_intro.json',
    ),
    ContentItem(
      title: 'The Direct Approach: Manual Focus',
      description: 'A rigid way to manage focus in your TV Nav Bar.',
      color: AppColors.amber2,
      slideAssetPath: 'assets/slides/info/4_traversal/2_manual_focus.json',
    ),
    ContentItem(
      title: 'Dividing the Screen: Scopes',
      description: 'Separating focus between the Nav Bar and the main content.',
      color: AppColors.amber3,
      slideAssetPath: 'assets/slides/info/4_traversal/3_scoping_ui.json',
    ),
    ContentItem(
      title: 'Creating Focus Zones with `FocusScope`',
      description: 'Using the `FocusScope` widget to trap focus.',
      color: AppColors.amber4,
      slideAssetPath:
          'assets/slides/info/4_traversal/4_focus_scope_widget.json',
    ),
    ContentItem(
      title: 'Under the Hood: `FocusScopeNode`',
      description: 'The object that powers the `FocusScope` widget.',
      color: AppColors.amber5,
      slideAssetPath: 'assets/slides/info/4_traversal/5_focus_scope_node.json',
    ),
    ContentItem(
      title: '`FocusTraversalGroup`',
      description: 'Defining a container for custom navigation.',
      color: AppColors.amber6,
      slideAssetPath:
          'assets/slides/info/4_traversal/6_focus_traversal_group.json',
    ),
    ContentItem(
      title: '`FocusTraversalPolicy`',
      description: 'The "rulebook" for defining focus order.',
      color: AppColors.amber7,
      slideAssetPath:
          'assets/slides/info/4_traversal/7_focus_traversal_policy.json',
    ),
    ContentItem(
      title: 'The Default Problem',
      description: 'Why the default policy fails on complex UIs.',
      color: AppColors.amber8,
      slideAssetPath:
          'assets/slides/info/4_traversal/8_reading_order_policy.json',
    ),
    ContentItem(
      title: 'The Default Path... to Madness',
      description: 'What happens when `ReadingOrderTraversalPolicy` meets a grid',
      color: AppColors.amber9,
      slideAssetPath:
      'assets/slides/info/4_traversal/9_madness.json',
    ),
  ],
);
final ContentRailData _fifthRail = ContentRailData(
  title: 'Management & Traversal',
  items: [
    ContentItem(
      title: 'Management & Traversal',
      description: 'Controlling the user\'s navigation path through the app.',
      color: Colors.teal.shade200,
      slideAssetPath: 'assets/slides/info/4_traversal/1_intro.json',
    ),
  ],
);
