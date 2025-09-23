import 'package:flutter/material.dart';

/// A custom ThemeExtension to hold a list of colors for background gradients.
/// This allows the background to adapt based on the current theme.
@immutable
class BackgroundGradientTheme extends ThemeExtension<BackgroundGradientTheme> {
  const BackgroundGradientTheme({required this.colors});

  final List<Color> colors;

  @override
  BackgroundGradientTheme copyWith({List<Color>? colors}) {
    return BackgroundGradientTheme(colors: colors ?? this.colors);
  }

  @override
  BackgroundGradientTheme lerp(
    ThemeExtension<BackgroundGradientTheme>? other,
    double t,
  ) {
    if (other is! BackgroundGradientTheme) {
      return this;
    }
    // A simple lerp isn't straightforward for a list of colors.
    // For theme transitions, we'll just switch at the halfway point.
    return t < 0.5 ? this : other;
  }
}
