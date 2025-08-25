import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/app_colors.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/slides/widgets/footer_widget.dart';

/// A private class to hold the text styles for the slide.
class _SlideTextStyles {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 64.0,
    fontWeight: FontWeight.bold,
    color: AppColors.contentTitle,
  );
  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 52.0,
    color: AppColors.contentSubtitle,
  );
}

/// The base layout for all presentation slides.
///
/// It provides a consistent structure with a title, subtitle, a main content area,
/// and a footer. The specific layout of the main content is passed in as the `child`.
class TemplateSlide extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? child;
  final List<Widget>? children;

  const TemplateSlide({
    super.key,
    required this.title,
    required this.subtitle,
    this.child,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.railData.railHorizontalPadding,
        vertical: context.railData.tileSize.height / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _SlideTextStyles.titleStyle,
          ),
          const SizedBox(height: 8.0),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _SlideTextStyles.subtitleStyle,
          ),
          const SizedBox(height: 32.0),
          // Constrain the height of the body content.
          Expanded(
            child:
                child ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children ?? [],
                ),
          ),
          Align(alignment: Alignment.bottomRight, child: const FooterWidget()),
        ],
      ),
    );
  }
}
