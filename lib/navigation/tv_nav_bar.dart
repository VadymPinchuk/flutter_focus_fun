import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/constants.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/navigation/tv_nav_bar_traversal_policy.dart';

class TvNavBar extends StatefulWidget {
  final int selectedIndex;
  final FocusNode parentNode;
  final ValueChanged<int> onItemSelected;

  const TvNavBar({
    super.key,
    this.selectedIndex = 0,
    required this.parentNode,
    required this.onItemSelected,
  });

  @override
  State<TvNavBar> createState() => _TvNavBarState();
}

class _TvNavBarState extends State<TvNavBar> {
  bool isFocused = false;
  late int selectedIndex = widget.selectedIndex;
  late final FocusNode focusNode = widget.parentNode;
  final List<FocusNode> navBarNodes = List.generate(
    4,
    (index) => FocusNode(debugLabel: 'TvNavBarItem $index'),
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
          navBarNodes[selectedIndex].requestFocus();
        }
      },
      child: FocusTraversalGroup(
        policy: TvNavBarTraversalPolicy(navBarNodes: navBarNodes),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: AnimatedContainer(
              curve: Curves.easeOut,
              duration: kAnimationDuration,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              width: isFocused ? 256.0 : 64.0,
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
                children: [
                  Spacer(),
                  _TvNavBarButton.home(
                    isSelected: selectedIndex == 0,
                    isFocused: isFocused,
                    focusNode: navBarNodes[0],
                    onPressed: () => itemSelected(0),
                  ),
                  const SizedBox(height: 24.0),
                  _TvNavBarButton.info(
                    isSelected: selectedIndex == 1,
                    isFocused: isFocused,
                    focusNode: navBarNodes[1],
                    onPressed: () => itemSelected(1),
                  ),
                  Spacer(),
                  _TvNavBarButton.about(
                    isSelected: selectedIndex == 2,
                    isFocused: isFocused,
                    focusNode: navBarNodes[2],
                    onPressed: () => itemSelected(2),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Divider(height: 1, color: Colors.white24),
                  ),
                  _TvNavBarButton.settings(
                    isSelected: selectedIndex == 3,
                    isFocused: isFocused,
                    focusNode: navBarNodes[3],
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

/// TV navigation bar buttons
typedef NavButtonIcon = ({IconData active, IconData inactive});

class _TvNavBarButton extends StatefulWidget {
  final FocusNode focusNode;
  final NavButtonIcon icon;
  final String label;
  final bool isSelected;
  final bool isFocused;
  final VoidCallback onPressed;

  const _TvNavBarButton.home({
    required this.onPressed,
    this.isSelected = false,
    this.isFocused = true,
    required this.focusNode,
  }) : icon = (active: Icons.home_rounded, inactive: Icons.home_outlined),
       label = 'HOME';

  const _TvNavBarButton.info({
    required this.onPressed,
    this.isSelected = false,
    this.isFocused = false,
    required this.focusNode,
  }) : icon = (
         active: Icons.info_rounded,
         inactive: Icons.info_outline_rounded,
       ),
       label = 'INFO';

  const _TvNavBarButton.about({
    required this.onPressed,
    this.isSelected = false,
    this.isFocused = false,
    required this.focusNode,
  }) : icon = (
         active: Icons.question_mark_rounded,
         inactive: Icons.question_mark_rounded,
       ),
       label = 'ABOUT';

  const _TvNavBarButton.settings({
    required this.onPressed,
    this.isSelected = false,
    this.isFocused = false,
    required this.focusNode,
  }) : icon = (
         active: Icons.settings_rounded,
         inactive: Icons.settings_outlined,
       ),
       label = 'SETTINGS';

  @override
  State<_TvNavBarButton> createState() => _TvNavBarButtonState();
}

class _TvNavBarButtonState extends State<_TvNavBarButton> {
  bool showLabel = false;

  @override
  void didUpdateWidget(covariant _TvNavBarButton oldWidget) {
    if (widget.isFocused == false) {
      setState(() {
        showLabel = false;
      });
    } else {
      Future.delayed(kAnimationDuration, () {
        if (mounted) {
          setState(() {
            showLabel = widget.isFocused;
          });
        }
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder<bool>(
      valueListenable: context.settingsModel.useFocusDecoration,
      builder: (context, useDecoration, child) {
        return TextButton(
          onPressed: widget.onPressed,
          focusNode: widget.focusNode,
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(const EdgeInsets.all(16.0)),
            minimumSize: WidgetStatePropertyAll(Size.zero),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              return useDecoration && states.contains(WidgetState.focused)
                  ? Colors.white10
                  : Colors.transparent;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              return useDecoration && states.contains(WidgetState.focused)
                  ? Colors.white
                  : Colors.white54;
            }),
            textStyle: WidgetStateProperty.resolveWith((states) {
              return useDecoration && states.contains(WidgetState.focused)
                  ? const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  )
                  : const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  );
            }),
          ),
          child: Row(
            children: [
              Icon(
                widget.isSelected ? widget.icon.active : widget.icon.inactive,
                color: widget.isSelected ? Colors.white : Colors.white54,
                size: 32.0,
              ),
              AnimatedSwitcher(
                duration: kAnimationDuration,
                child: SizedBox(width: showLabel ? 8.0 : 0.0),
              ),
              AnimatedSwitcher(
                duration: kAnimationDuration,
                child: showLabel ? Text(widget.label) : const SizedBox.shrink(),
              ),
            ],
          ),
        );
      },
    );
  }
}
