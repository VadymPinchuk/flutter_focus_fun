import 'dart:ui';

import 'package:flutter/material.dart';

/// A vertical navigation rail for the TV UI.
class LeftNavRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTapped;

  const LeftNavRail({
    super.key,
    required this.selectedIndex,
    required this.onTapped,
  });

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
