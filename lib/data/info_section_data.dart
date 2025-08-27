import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_rail_data.dart';

/// InfoSection data
final List<ContentRailData> infoSectionRails = [
  _firstRail,
  _secondRail,
  _thirdRail,
];

final ContentRailData _firstRail = ContentRailData(
  title: 'Setting the Stage',
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
      slideAssetPath: 'assets/slides/info/1_setting_the_stage/2_why_care.json',
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
      color: Colors.indigo.shade900,
      slideAssetPath: 'assets/slides/info/2_core_components/1_intro.json',
    ),
    ContentItem(
      title: 'The Atom',
      description: 'The brain of a focusable widget.',
      color: Colors.indigo.shade800,
      slideAssetPath: 'assets/slides/info/2_core_components/2_focus_node.json',
    ),
    ContentItem(
      title: 'The Workhorse',
      description: 'Bringing a FocusNode to the Widget Tree.',
      color: Colors.deepPurple.shade900,
      slideAssetPath:
          'assets/slides/info/2_core_components/3_focus_widget.json',
    ),
    ContentItem(
      title: 'Visualizing Focus',
      description: 'Providing clear visual feedback for the active element.',
      color: Colors.deepPurple.shade800,
      slideAssetPath:
          'assets/slides/info/2_core_components/4_visualizing_focus.json',
    ),
    ContentItem(
      title: 'Input Response',
      description: 'How to make your focused widget react to key presses.',
      color: Colors.deepPurple.shade700,
      slideAssetPath:
          'assets/slides/info/2_core_components/5_responding_to_input.json',
    ),
    ContentItem(
      title: 'KeyboardListener',
      description: 'For when you need direct access to raw key presses.',
      color: Colors.deepPurple.shade600,
      slideAssetPath:
          'assets/slides/info/2_core_components/6_keyboard_listener.json',
    ),
    ContentItem(
      title: 'Actions & Intents',
      description: 'Decoupling what the user wants from how it\'s done.',
      color: Colors.deepPurple.shade500,
      slideAssetPath:
          'assets/slides/info/2_core_components/7_actions_intents.json',
    ),
    ContentItem(
      title: 'Shortcuts',
      description: 'Actions and Intents in Action ><',
      color: Colors.deepPurple.shade400,
      slideAssetPath:
          'assets/slides/info/2_core_components/8_shortcuts.json',
    ),
    ContentItem(
      title: 'CallbackShortcuts',
      description: 'Using built-in widgets for common keyboard actions.',
      color: Colors.purple.shade300,
      slideAssetPath:
          'assets/slides/info/2_core_components/9_callback_shortcuts.json',
    ),
    ContentItem(
      title: 'The All-in-One: FocusableActionDetector',
      description: 'Your new best friend for interactive components.',
      color: Colors.purple.shade400,
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
      color: Colors.amber.shade400,
      slideAssetPath: 'assets/slides/info/3_big_picture/1_intro.json',
    ),
    ContentItem(
      title: 'The Focus Tree',
      description: 'How Flutter organizes all focusable widgets.',
      color: Colors.amber.shade500,
      slideAssetPath: 'assets/slides/info/3_big_picture/2_focus_tree.json',
    ),
    ContentItem(
      title: 'Debugging Focus',
      description: 'Using `debugDumpFocusTree()` to visualize your focus tree.',
      color: Colors.amber.shade600,
      slideAssetPath: 'assets/slides/info/3_big_picture/3_debugging_focus.json',
    ),
    ContentItem(
      title: 'FocusManager',
      description: 'The singleton that orchestrates the entire focus system.',
      color: Colors.amber.shade700,
      slideAssetPath: 'assets/slides/info/3_big_picture/4_focus_manager.json',
    ),
    ContentItem(
      title: 'FocusManager in Action',
      description: 'Key methods for interacting with the focus tree.',
      color: Colors.amber.shade800,
      slideAssetPath:
          'assets/slides/info/3_big_picture/5_focus_manager_methods.json',
    ),
  ],
);
