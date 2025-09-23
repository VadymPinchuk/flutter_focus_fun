import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/app_colors.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// A widget that renders a string of Markdown content with a
/// predefined, slide-friendly style sheet.
class MarkdownText extends StatelessWidget {
  final String text;

  const MarkdownText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    // Use MarkdownBody for rendering without extra padding or scrolling.
    // This is ideal for embedding within a slide layout.
    return MarkdownBody(data: text, styleSheet: context.sharedStyleSheet);
  }
}

extension on BuildContext {
  MarkdownStyleSheet get sharedStyleSheet {
    final theme = Theme.of(this);
    return MarkdownStyleSheet(
      // Style for regular paragraph text
      p: TextStyle(
        fontSize: 23.0,
        color: theme.textTheme.bodyLarge!.color!,
        height: 1.5, // Improves readability for blocks of text
      ),
      // Style for inline code (text inside `backticks`)
      code: TextStyle(
        fontSize: 22.0,
        color: theme.colorScheme.primary.withValues(alpha: 0.7),
        // backgroundColor: theme.textTheme.bodyLarge!.color!.withValues(alpha: 0.1),
        fontFamily: 'monospace',
      ),
      // Style for H1 headers (e.g., "# Header")
      h1: TextStyle(
        fontSize: 64.0,
        fontWeight: FontWeight.bold,
        color: theme.textTheme.headlineLarge!.color!,
      ),
      // Style for H2 headers (e.g., "## Sub-Header")
      h2: TextStyle(
        fontSize: 52.0,
        fontWeight: FontWeight.w600,
        color: theme.textTheme.headlineLarge!.color!,
      ),
      // You can also define styles for other elements like lists, links, etc.
      listBullet: TextStyle(
        fontSize: 24.0,
        color: theme.textTheme.bodyLarge!.color!.withValues(alpha: 0.75),
      ),
    );
  }
}
