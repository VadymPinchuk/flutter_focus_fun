import 'package:flutter/material.dart';

/// A horizontal navigation bar for the TV UI.
class TopNavRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTapped;

  const TopNavRail({
    super.key,
    required this.selectedIndex,
    required this.onTapped,
  });

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
