import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/side_menu/side_menu_traversal_policy.dart';

class SideMenu extends StatefulWidget {
  final int selectedIndex;
  final FocusNode focusNode;
  final ValueChanged<int> onItemSelected;

  const SideMenu({
    super.key,
    this.selectedIndex = 0,
    required this.focusNode,
    required this.onItemSelected,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool isFocused = false;
  late int selectedIndex = widget.selectedIndex;
  late final FocusNode focusNode = widget.focusNode;
  final List<FocusNode> sideMenuNodes = List.generate(
    4,
    (index) => FocusNode(debugLabel: 'SideMenuItem $index'),
  );

  void itemSelected(int index) {
    selectedIndex = index;
    focusNode.unfocus();
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      skipTraversal: true,
      parentNode: focusNode,
      onFocusChange: (isFocused) {
        setState(() {
          this.isFocused = isFocused;
        });
        if (isFocused) {
          sideMenuNodes[selectedIndex].requestFocus();
        }
      },
      child: FocusTraversalGroup(
        policy: SideMenuTraversalPolicy(sideMenuNodes: sideMenuNodes),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: AnimatedContainer(
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
              width: isFocused ? 240 : 66,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(isFocused ? 100 : 0),
                    blurRadius: 20,
                    spreadRadius: 10,
                    offset: const Offset(10, 0),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 32,
                children: [
                  _SideMenuButton.search(
                    isSelected: selectedIndex == 0,
                    showLabel: isFocused,
                    focusNode: sideMenuNodes[0],
                    onPressed: () => itemSelected(0),
                  ),
                  _SideMenuButton.home(
                    isSelected: selectedIndex == 1,
                    showLabel: isFocused,
                    focusNode: sideMenuNodes[1],
                    onPressed: () => itemSelected(1),
                  ),
                  _SideMenuButton.watchlist(
                    isSelected: selectedIndex == 2,
                    showLabel: isFocused,
                    focusNode: sideMenuNodes[2],
                    onPressed: () => itemSelected(2),
                  ),
                  _SideMenuButton.settings(
                    isSelected: selectedIndex == 3,
                    showLabel: isFocused,
                    focusNode: sideMenuNodes[3],
                    onPressed: () => itemSelected(3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SideMenuButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isSelected;
  final IconData icon;
  final String label;
  final bool showLabel;
  final FocusNode focusNode;

  const _SideMenuButton.search({
    required this.onPressed,
    this.isSelected = false,
    this.showLabel = false,
    required this.focusNode,
  }) : icon = Icons.search,
       label = 'SEARCH';

  const _SideMenuButton.home({
    required this.onPressed,
    this.isSelected = false,
    this.showLabel = true,
    required this.focusNode,
  }) : icon = Icons.home,
       label = 'HOME';

  const _SideMenuButton.watchlist({
    required this.onPressed,
    this.isSelected = false,
    this.showLabel = false,
    required this.focusNode,
  }) : icon = Icons.add,
       label = 'WATCHLIST';

  const _SideMenuButton.settings({
    required this.onPressed,
    this.isSelected = false,
    this.showLabel = false,
    required this.focusNode,
  }) : icon = Icons.settings,
       label = 'SETTINGS';

  @override
  State<_SideMenuButton> createState() => _SideMenuButtonState();
}

class _SideMenuButtonState extends State<_SideMenuButton> {
  bool showLabel = false;

  @override
  void didUpdateWidget(covariant _SideMenuButton oldWidget) {
    if (widget.showLabel == false) {
      setState(() {
        showLabel = false;
      });
    } else {
      Future.delayed(const Duration(milliseconds: 250), () {
        if (mounted) {
          setState(() {
            showLabel = widget.showLabel;
          });
        }
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Icon(
          widget.icon,
          color: widget.isSelected ? Colors.white : Colors.white54,
          size: 24,
        ),
        TextButton(
          onPressed: widget.onPressed,
          focusNode: widget.focusNode,
          style: ButtonStyle(
            padding: WidgetStateProperty.resolveWith((states) {
              return showLabel
                  ? const EdgeInsets.symmetric(horizontal: 12)
                  : EdgeInsets.zero;
            }),
            minimumSize: WidgetStatePropertyAll(Size.zero),
            backgroundBuilder: (context, states, child) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color:
                          states.contains(WidgetState.focused)
                              ? Colors.white
                              : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: child,
              );
            },
            shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.focused)) {
                return Colors.white;
              }
              return Colors.white54;
            }),
            textStyle: WidgetStatePropertyAll(
              const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: showLabel ? Text(widget.label) : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
