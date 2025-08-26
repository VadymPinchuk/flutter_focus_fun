import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';

/// A wrapper that handles the fade-in/out animation for a single rail.
class RailWrapper extends StatefulWidget {
  final int railIndex;
  final Widget child;

  const RailWrapper({super.key, required this.railIndex, required this.child});

  @override
  State<RailWrapper> createState() => _RailWrapperState();
}

class _RailWrapperState extends State<RailWrapper> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: context.settingsModel.useTvPageLayout,
      builder: (_, tvPageLayout, _) {
        return ValueListenableBuilder<int>(
          valueListenable: context.pageUiModel.focusedRailIndex,
          builder: (_, focusedRailIndex, child) {
            final bool isVisible =
                tvPageLayout ? widget.railIndex >= focusedRailIndex : true;
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isVisible ? 1.0 : 0.0,
              child: IgnorePointer(ignoring: !isVisible, child: child),
            );
          },
          child: widget.child,
        );
      },
    );
  }
}
