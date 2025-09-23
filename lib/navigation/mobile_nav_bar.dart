import 'dart:ui';

import 'package:flutter/material.dart';

class MobileNavBar extends StatefulWidget {
  final int selectedIndex;
  final FocusNode parentNode;
  final ValueChanged<int> onItemSelected;

  const MobileNavBar({
    super.key,
    this.selectedIndex = 0,
    required this.parentNode,
    required this.onItemSelected,
  });

  @override
  State<MobileNavBar> createState() => _MobileNavBarState();
}

class _MobileNavBarState extends State<MobileNavBar> {
  bool isFocused = false;
  late int selectedIndex = widget.selectedIndex;
  late final FocusNode parentNode = widget.parentNode;
  final List<FocusNode> navBarNodes = List.generate(
    3,
    (index) => FocusNode(debugLabel: 'MobileNavBarItem $index'),
  );

  void selectMenuItem(int index) {
    selectedIndex = index;
    parentNode.unfocus();
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRect(
      child: ClipRect(
        child: ColoredBox(
          color: Colors.blueGrey[900]!.withValues(alpha: 0.75),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              currentIndex: selectedIndex,
              onTap: selectMenuItem,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    selectedIndex == 0
                        ? Icons.home_rounded
                        : Icons.home_outlined,
                    color:
                        selectedIndex == 0
                            ? theme.colorScheme.primary
                            : theme.colorScheme.secondary,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    selectedIndex == 1
                        ? Icons.info_rounded
                        : Icons.info_outline_rounded,
                    color:
                        selectedIndex == 1
                            ? theme.colorScheme.primary
                            : theme.colorScheme.secondary,
                  ),
                  label: 'Info',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    selectedIndex == 2
                        ? Icons.question_mark_sharp
                        : Icons.question_mark_rounded,
                    color:
                        selectedIndex == 2
                            ? theme.colorScheme.primary
                            : theme.colorScheme.secondary,
                  ),
                  label: 'About',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    selectedIndex == 3
                        ? Icons.settings
                        : Icons.settings_rounded,
                    color:
                        selectedIndex == 3
                            ? theme.colorScheme.primary
                            : theme.colorScheme.secondary,
                  ),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
