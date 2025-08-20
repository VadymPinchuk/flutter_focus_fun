import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/constants.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/slides/widgets/footer_widget.dart';

/// A private class to hold the text styles for the slide.
class _SlideTextStyles {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.bold,
    color: Color(0xFFFFFFFF),
  );
  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 56,
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

  const TemplateSlide({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isHorizontalNavBar =
        context.settingsModel.uiExperience.value.isMobile;
    final railPadding = isHorizontalNavBar ? 48.0 : 80.0;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: railPadding,
            vertical: 48.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _SlideTextStyles.titleStyle),
              const SizedBox(height: 8),
              Text(subtitle, style: _SlideTextStyles.subtitleStyle),
              const SizedBox(height: 32),
              // Constrain the height of the body content.
              child,
            ],
          ),
        ),
        // Position the static footer at the bottom right.
        Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.symmetric(
            horizontal: railPadding,
            vertical: kRailHeight / 2,
          ),
          child: const FooterWidget(),
        ),
      ],
    );
  }
}
