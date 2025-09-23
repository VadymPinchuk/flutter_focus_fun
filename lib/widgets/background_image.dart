import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/theme/background_gradient_theme.dart';

/// A widget that displays a background gradient that adapts to the current theme.
///
/// It uses a custom [BackgroundGradientTheme] extension to get the appropriate
/// colors for the gradient, ensuring a consistent look and feel.
class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // 1. Get the custom gradient theme extension from the current theme.
    final gradientTheme =
        Theme.of(context).extension<BackgroundGradientTheme>();

    // It's good practice to provide a fallback in case the extension isn't found.
    final gradientColors =
        gradientTheme?.colors ??
        [
          colorScheme.surface,
          colorScheme.surface.withValues(alpha: 0.5),
          colorScheme.surface.withValues(alpha: 0.8),
        ];

    return AnimatedContainer(
      height: double.infinity,
      width: double.infinity,
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: gradientColors,
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}
