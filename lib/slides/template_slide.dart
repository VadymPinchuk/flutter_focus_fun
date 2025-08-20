import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/footer_widget.dart';

/// A private class to hold the text styles for the slide.
class _SlideTextStyles {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: Color(0xFFFFFFFF),
  );
  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 24,
    color: Color(0xE6FFFFFF),
  );
}

/// The base layout for all presentation slides.
///
/// It provides a consistent structure with a title, subtitle, a main content area,
/// and a footer. The specific layout of the main content is passed in as the `child`.
class TemplateSlide extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  static const double _kRailHeight = 192.0;

  const TemplateSlide({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // This calculation determines the space available for the slide content above the rails.
    final contentHeight = screenHeight - (1.5 * _kRailHeight);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 120, top: 100, right: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _SlideTextStyles.titleStyle),
              const SizedBox(height: 8),
              Text(subtitle, style: _SlideTextStyles.subtitleStyle),
              const SizedBox(height: 32),
              // Constrain the height of the body content.
              SizedBox(
                height: contentHeight - 220, // Adjust for title/padding
                child: child,
              ),
            ],
          ),
        ),
        // Position the static footer at the bottom right.
        Positioned(
          bottom: (1.5 * _kRailHeight) + 24, // Position above the rails
          right: 48,
          left: 120,
          child: const FooterWidget(),
        ),
      ],
    );
  }
}
