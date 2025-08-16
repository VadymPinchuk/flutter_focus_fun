import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/custom_traversal_policy.dart';
import 'package:flutter_focus_fun_tv_demo/model/page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/navigation/mobile_nav_bar.dart';
import 'package:flutter_focus_fun_tv_demo/navigation/mobile_status_bar_overlay.dart';
import 'package:flutter_focus_fun_tv_demo/navigation/tv_nav_bar.dart';
import 'package:flutter_focus_fun_tv_demo/pages/any_page.dart';
import 'package:flutter_focus_fun_tv_demo/pages/info_page.dart';
import 'package:flutter_focus_fun_tv_demo/pages/settings_page.dart';
import 'package:flutter_focus_fun_tv_demo/shortcuts/keyboard_shortcuts.dart';
import 'package:flutter_focus_fun_tv_demo/utils/scope_functions.dart';
import 'package:flutter_focus_fun_tv_demo/utils/ui_experience.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider;

import '../pages/home_page.dart';

class ScreenScaffold extends StatefulWidget {
  const ScreenScaffold({super.key});

  @override
  State<ScreenScaffold> createState() => _ScreenScaffoldState();
}

class _ScreenScaffoldState extends State<ScreenScaffold> {
  int _selectedIndex = 0;

  /// Focus nodes
  final FocusScopeNode _navBarScopeNode = FocusScopeNode(
    debugLabel: 'NavBarScope',
  );
  final FocusScopeNode _homePageScopeNode = FocusScopeNode(
    debugLabel: 'HomePageScope',
  );
  final FocusScopeNode _infoPageScopeNode = FocusScopeNode(
    debugLabel: 'InfoPageScope',
  );
  final FocusScopeNode _settingsPageScopeNode = FocusScopeNode(
    debugLabel: 'SettingsPageScope',
  );
  final FocusScopeNode _aboutPageScopeNode = FocusScopeNode(
    debugLabel: 'AboutPageScope',
  );

  late final pageScopeNodes = [
    _homePageScopeNode,
    _infoPageScopeNode,
    _settingsPageScopeNode,
    _aboutPageScopeNode,
  ];

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      const HomePage(key: Key('HomePage')),
      const InfoPage(key: Key('InfoPage')),
      const SettingsPage(),
      const AnyPage(key: Key('AboutPage')),
    ];
  }

  Widget _buildPageScope(int index, FocusScopeNode focusNode) {
    return FocusScope(
      key: Key('PageScopeNode $index'),
      node: focusNode,
      onKeyEvent: (node, event) {
        return _maybeFocusOnNavBar(pageScopeNodes[index], event);
      },
      child: pages[index],
    ).let(
      (page) => ValueListenableBuilder(
        valueListenable: context.settingsModel.useCustomTraversalPolicy,
        builder: (_, usePolicy, _) {
          return usePolicy
              ? FocusTraversalGroup(
                policy: CustomTraversalPolicy(),
                child: page,
              )
              : page;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: {
        MenuIntent: CallbackAction<MenuIntent>(
          onInvoke: (intent) => _navBarScopeNode.requestFocus(),
        ),
        DismissIntent: CallbackAction<DismissIntent>(
          onInvoke: (intent) => _navBarScopeNode.requestFocus(),
        ),
      },
      child: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: [
              _buildPageScope(0, _homePageScopeNode),
              _buildPageScope(1, _infoPageScopeNode),
              FocusScope(
                node: _settingsPageScopeNode,
                onKeyEvent: (node, event) {
                  return _maybeFocusOnNavBar(
                    pageScopeNodes[_selectedIndex],
                    event,
                  );
                },
                child: const SettingsPage(),
              ),
              _buildPageScope(3, _aboutPageScopeNode),
            ],
          ),
          ValueListenableBuilder<UiExperience>(
            valueListenable: context.settingsModel.uiExperience,
            builder:
                (_, uiExperience, _) => switch (uiExperience) {
                  UiExperience.tv => const SizedBox.shrink(),
                  UiExperience.mobile => Align(
                    alignment: Alignment.topCenter,
                    child: MobileStatusBarOverlay(),
                  ),
                },
          ),
          FocusScope(
            node: _navBarScopeNode,
            onKeyEvent: (node, event) {
              return _focusOnMainPanel(event);
            },
            child: ValueListenableBuilder<UiExperience>(
              valueListenable: context.settingsModel.uiExperience,
              builder:
                  (_, uiExperience, _) => switch (uiExperience) {
                    UiExperience.tv => TvNavBar(
                      parentNode: _navBarScopeNode,
                      selectedIndex: _selectedIndex,
                      onItemSelected: handleNavBarClick,
                    ),
                    UiExperience.mobile => Align(
                      alignment: Alignment.bottomCenter,
                      child: MobileNavBar(
                        parentNode: _navBarScopeNode,
                        selectedIndex: _selectedIndex,
                        onItemSelected: handleNavBarClick,
                      ),
                    ),
                  },
            ),
          ),
        ],
      ),
    );
  }

  void handleNavBarClick(int index) {
    setState(() {
      _selectedIndex = index;
      final targetScopeNode = pageScopeNodes[_selectedIndex];
      targetScopeNode.requestFocus();
    });
  }

  KeyEventResult _focusOnMainPanel(KeyEvent event) {
    if (event is KeyUpEvent &&
        event.logicalKey == LogicalKeyboardKey.arrowRight) {
      pageScopeNodes[_selectedIndex].requestFocus();

      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  KeyEventResult _maybeFocusOnNavBar(FocusScopeNode node, KeyEvent event) {
    if (event is KeyUpEvent) {
      return KeyEventResult.handled;
    }
    if (event.logicalKey != LogicalKeyboardKey.arrowLeft) {
      return KeyEventResult.ignored;
    }

    if (!node.focusInDirection(TraversalDirection.left)) {
      if (_navBarScopeNode.focusedChild == null) {
        _navBarScopeNode.focusInDirection(TraversalDirection.left);
      } else {
        _navBarScopeNode.requestFocus();
      }
    }
    return KeyEventResult.handled;
  }
}
