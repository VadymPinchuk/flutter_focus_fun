import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/app_colors.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/slides/widgets/footer_widget.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

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
        vertical: context.railData.tileSize.height / 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SlideTitle(title),
          const SizedBox(height: 8.0),
          _SlideSubTitle(subtitle),
          const SizedBox(height: 16.0),
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
          const SizedBox(height: 16.0),
          Align(alignment: Alignment.bottomRight, child: const FooterWidget()),
        ],
      ),
    );
  }
}

class _SlideTitle extends StatelessWidget {
  final String text;

  const _SlideTitle(this.text);

  @override
  Widget build(BuildContext context) {
    // Use MarkdownBody for rendering without extra padding or scrolling.
    // This is ideal for embedding within a slide layout.
    return MarkdownBody(data: text, styleSheet: _templateTextStyle(64.0, 1.0));
  }
}

class _SlideSubTitle extends StatelessWidget {
  final String text;

  const _SlideSubTitle(this.text);

  @override
  Widget build(BuildContext context) {
    // Use MarkdownBody for rendering without extra padding or scrolling.
    // This is ideal for embedding within a slide layout.
    return MarkdownBody(data: text, styleSheet: _templateTextStyle(50.0, 0.7));
  }
}

MarkdownStyleSheet _templateTextStyle(double size, double alpha) =>
    MarkdownStyleSheet(
      p: TextStyle(
        fontSize: size,
        color: AppColors.contentTitle.withValues(alpha: alpha),
        fontWeight: FontWeight.bold,
        height: 1.5,
      ),
      em:  TextStyle(
        fontSize: size,
        color: AppColors.emerald1.withValues(alpha: alpha),
        fontStyle: FontStyle.italic,
        height: 1.5,
      ),
      code: TextStyle(
        fontSize: size,
        color: Colors.amber.shade200.withValues(alpha: alpha),
        fontWeight: FontWeight.bold,
        fontFamily: 'monospace',
      ),
    );
