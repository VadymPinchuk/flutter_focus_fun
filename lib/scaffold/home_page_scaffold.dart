import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_focus_fun_tv_demo/grid_traversal_policy.dart';
import 'package:flutter_focus_fun_tv_demo/model/page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/pages/current/current_page.dart';
import 'package:flutter_focus_fun_tv_demo/pages/intro/intro_page.dart';
import 'package:flutter_focus_fun_tv_demo/pages/resolution/resolution_page.dart';
import 'package:flutter_focus_fun_tv_demo/pages/summary_page.dart';
import 'package:flutter_focus_fun_tv_demo/side_menu/side_menu.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider;

class HomePageScaffold extends StatefulWidget {
  final PageController pageController;
  final int selectedIndex;
  final ValueChanged<int> onNavItemTapped;
  final ValueChanged<int> onPageChanged;
  final List<PageUiModel> pageModels;

  const HomePageScaffold({
    super.key,
    required this.pageController,
    required this.selectedIndex,
    required this.onNavItemTapped,
    required this.onPageChanged,
    required this.pageModels,
  });

  @override
  State<HomePageScaffold> createState() => _HomePageScaffoldState();
}

class _HomePageScaffoldState extends State<HomePageScaffold> {
  int _selectedIndex = 1;
  final FocusScopeNode _sideMenuScopeNode = FocusScopeNode(
    debugLabel: 'SideMenuScope',
  );
  final FocusScopeNode _currentPageScopeNode = FocusScopeNode(
    debugLabel: 'CurrentPageScope',
  );
  final FocusScopeNode _introPageScopeNode = FocusScopeNode(
    debugLabel: 'IntroPageScope',
  );
  final FocusScopeNode _resolutionPageScopeNode = FocusScopeNode(
    debugLabel: 'ResolutionPageScope',
  );
  final FocusScopeNode _conclusionPageScopeNode = FocusScopeNode(
    debugLabel: 'ConclusionPageScope',
  );

  late final rightPanelScopeNodes = [
    _currentPageScopeNode,
    _introPageScopeNode,
    _resolutionPageScopeNode,
    _conclusionPageScopeNode,
  ];

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: {
        DismissIntent: CallbackAction<DismissIntent>(
          onInvoke: (intent) => _sideMenuScopeNode.requestFocus(),
        ),
      },
      child: Stack(
        children: [
            IndexedStack(
            index: _selectedIndex,
            children: [
              FocusScope(
                node: _currentPageScopeNode,
                onKeyEvent: (node, event) {
                  return _focusOnSideMenuIfNeeded(
                    rightPanelScopeNodes[_selectedIndex],
                    event,
                  );
                },
                child: ChangeNotifierProvider.value(
                  value: widget.pageModels[0],
                  child: const CurrentPage(),
                ),
              ),
              FocusTraversalGroup(
                policy: GridTraversalPolicy(),
                child: FocusScope(
                  node: _introPageScopeNode,
                  onKeyEvent: (node, event) {
                    return _focusOnSideMenuIfNeeded(
                      rightPanelScopeNodes[_selectedIndex],
                      event,
                    );
                  },
                  child: ChangeNotifierProvider.value(
                    value: widget.pageModels[1],
                    child: const IntroPage(),
                  ),
                ),
              ),
              FocusScope(
                node: _resolutionPageScopeNode,
                onKeyEvent: (node, event) {
                  return _focusOnSideMenuIfNeeded(
                    rightPanelScopeNodes[_selectedIndex],
                    event,
                  );
                },
                child: ChangeNotifierProvider.value(
                  value: widget.pageModels[2],
                  child: const ResolutionPage(),
                ),
              ),
              FocusScope(
                node: _conclusionPageScopeNode,
                onKeyEvent: (node, event) {
                  return _focusOnSideMenuIfNeeded(
                    rightPanelScopeNodes[_selectedIndex],
                    event,
                  );
                },
                child: ChangeNotifierProvider.value(
                  value: widget.pageModels[3],
                  child: const SummaryPage(),
                ),
              ),
            ],
          ),
          FocusScope(
            node: _sideMenuScopeNode,
            onKeyEvent: (node, event) {
              return _focusOnMainPanel(event);
            },
            child: SideMenu(
              focusNode: _sideMenuScopeNode,
              selectedIndex: _selectedIndex,
              onItemSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                  final targetScopeNode = rightPanelScopeNodes[_selectedIndex];
                  targetScopeNode.requestFocus();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  KeyEventResult _focusOnMainPanel(KeyEvent event) {
    if (event is KeyUpEvent &&
        event.logicalKey == LogicalKeyboardKey.arrowRight) {
      rightPanelScopeNodes[_selectedIndex].requestFocus();

      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  KeyEventResult _focusOnSideMenuIfNeeded(FocusScopeNode node, KeyEvent event) {
    if (event is KeyUpEvent) {
      return KeyEventResult.handled;
    }
    if (event.logicalKey != LogicalKeyboardKey.arrowLeft) {
      return KeyEventResult.ignored;
    }

    if (!node.focusInDirection(TraversalDirection.left)) {
      if (_sideMenuScopeNode.focusedChild == null) {
        _sideMenuScopeNode.focusInDirection(TraversalDirection.left);
      } else {
        _sideMenuScopeNode.requestFocus();
      }
    }
    return KeyEventResult.handled;
  }
}
