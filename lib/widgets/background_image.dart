import 'package:flutter/material.dart';
import 'package:flutter_focus_fun/theme/background_gradient_theme.dart';

/// A widget that displays a background gradient that adapts to the current theme.
///
/// It uses a custom [BackgroundGradientTheme] extension to get the appropriate
/// colors for the gradient, ensuring a consistent look and feel.
class BackgroundImage extends StatelessWidget {
  final List<Color>? colors;

  const BackgroundImage({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final gradientColors =
        colors ??
        [
          colorScheme.surface,
          colorScheme.surface.withValues(alpha: 0.5),
          colorScheme.surface.withValues(alpha: 0.8),
          colorScheme.surface,
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
        ),
      ),
    );
  }
}
