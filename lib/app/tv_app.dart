import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/model/page_scroll_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/model/tv_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/pages/intro_page.dart';
import 'package:flutter_focus_fun_tv_demo/pages/resolution_page.dart';
import 'package:flutter_focus_fun_tv_demo/pages/summary_page.dart';
import 'package:flutter_focus_fun_tv_demo/scaffold/tv_screen_scaffold.dart';
import 'package:provider/provider.dart';

class TvApp extends StatelessWidget {
  final PageController pageController;
  final int selectedIndex;
  final ValueChanged<int> onNavItemTapped;
  final ValueChanged<int> onPageChanged;
  final List<PageScrollUiModel> pageScrollStates;

  const TvApp({
    super.key,
    required this.pageController,
    required this.selectedIndex,
    required this.onNavItemTapped,
    required this.onPageChanged,
    required this.pageScrollStates,
  });

  @override
  Widget build(BuildContext context) {
    Widget pageView = PageView(
      controller: pageController,
      onPageChanged: onPageChanged,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ChangeNotifierProvider.value(
          value: pageScrollStates[0],
          child: const IntroPage(),
        ),
        ChangeNotifierProvider.value(
          value: pageScrollStates[1],
          child: const ResolutionPage(),
        ),
        ChangeNotifierProvider.value(
          value: pageScrollStates[2],
          child: const SummaryPage(),
        ),
      ],
    );

    return TvScreenScaffold(
      body: pageView,
      header:ValueListenableBuilder<TvNavBarLocation>(
        valueListenable: context.read<TvUiModel>().navBarLocation,
        builder:
            (_, location, _) => switch (location) {
              TvNavBarLocation.left => _LeftNavRail(
                selectedIndex: selectedIndex,
                onTapped: onNavItemTapped,
              ),
              TvNavBarLocation.top => _TopNavBar(
                selectedIndex: selectedIndex,
                onTapped: onNavItemTapped,
              ),
            },
      ),
    );
  }
}

/// A horizontal navigation bar for the TV UI.
class _TopNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTapped;

  const _TopNavBar({required this.selectedIndex, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _TopNavButton(
            label: 'Intro',
            isSelected: selectedIndex == 0,
            onPressed: () => onTapped(0),
            autofocus: true,
          ),
          const SizedBox(width: 24),
          _TopNavButton(
            label: 'Resolution',
            isSelected: selectedIndex == 1,
            onPressed: () => onTapped(1),
          ),
          const SizedBox(width: 24),
          _TopNavButton(
            label: 'Summary',
            isSelected: selectedIndex == 2,
            onPressed: () => onTapped(2),
          ),
        ],
      ),
    );
  }
}

/// A focusable button for the top navigation bar.
class _TopNavButton extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;
  final bool autofocus;

  const _TopNavButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
    this.autofocus = false,
  });

  @override
  State<_TopNavButton> createState() => _TopNavButtonState();
}

class _TopNavButtonState extends State<_TopNavButton> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: Matrix4.identity()..scale(_isFocused ? 1.15 : 1.0),
      transformAlignment: Alignment.center,
      child: Focus(
        autofocus: widget.autofocus,
        onFocusChange: (hasFocus) {
          setState(() {
            _isFocused = hasFocus;
          });
          if (hasFocus) {
            widget.onPressed();
          }
        },
        child: TextButton(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
            backgroundColor:
                widget.isSelected
                    ? Colors.white
                    : (_isFocused
                        ? Colors.white.withValues(alpha: 0.2)
                        : Colors.transparent),
            foregroundColor: widget.isSelected ? Colors.black : Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            widget.label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

/// A vertical navigation rail for the TV UI.
class _LeftNavRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTapped;

  const _LeftNavRail({required this.selectedIndex, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          width: 100,
          color: Colors.black.withValues(alpha: 0.3),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _NavRailButton(
                  icon: selectedIndex == 0 ? Icons.help : Icons.help_outline,
                  isSelected: selectedIndex == 0,
                  onPressed: () => onTapped(0),
                  autofocus: true,
                ),
                const SizedBox(height: 24),
                _NavRailButton(
                  icon:
                      selectedIndex == 1
                          ? Icons.lightbulb
                          : Icons.lightbulb_outline,
                  isSelected: selectedIndex == 1,
                  onPressed: () => onTapped(1),
                ),
                const SizedBox(height: 24),
                _NavRailButton(
                  icon:
                      selectedIndex == 2
                          ? Icons.assignment_turned_in
                          : Icons.assignment_turned_in_outlined,
                  isSelected: selectedIndex == 2,
                  onPressed: () => onTapped(2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A focusable icon button for the vertical navigation rail.
class _NavRailButton extends StatefulWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;
  final bool autofocus;

  const _NavRailButton({
    required this.icon,
    required this.isSelected,
    required this.onPressed,
    this.autofocus = false,
  });

  @override
  State<_NavRailButton> createState() => _NavRailButtonState();
}

class _NavRailButtonState extends State<_NavRailButton> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: Matrix4.identity()..scale(_isFocused ? 1.1 : 1.0),
      transformAlignment: Alignment.center,
      child: Focus(
        autofocus: widget.autofocus,
        onFocusChange: (hasFocus) {
          setState(() {
            _isFocused = hasFocus;
          });
          if (hasFocus) {
            widget.onPressed();
          }
        },
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              widget.icon,
              size: _isFocused ? 32 : 28,
              color:
                  _isFocused || widget.isSelected
                      ? Colors.white
                      : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
