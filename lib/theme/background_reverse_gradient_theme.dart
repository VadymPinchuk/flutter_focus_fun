import 'package:flutter/material.dart';

/// A custom ThemeExtension to hold a list of colors for background gradients.
/// This allows the background to adapt based on the current theme.
@immutable
class BackgroundReverseGradientTheme
    extends ThemeExtension<BackgroundReverseGradientTheme> {
  const BackgroundReverseGradientTheme({required this.colors});

  final List<Color> colors;

  @override
  BackgroundReverseGradientTheme copyWith({List<Color>? colors}) {
    return BackgroundReverseGradientTheme(colors: colors ?? this.colors);
  }

  @override
  BackgroundReverseGradientTheme lerp(
    ThemeExtension<BackgroundReverseGradientTheme>? other,
    double t,
  ) {
    if (other is! BackgroundReverseGradientTheme) {
      return this;
    }
    // A simple lerp isn't straightforward for a list of colors.
    // For theme transitions, we'll just switch at the halfway point.
    return t < 0.5 ? this : other;
  }
}
