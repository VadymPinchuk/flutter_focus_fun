import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/app_colors.dart';
import 'package:flutter_focus_fun_tv_demo/data_models/bullet_point.dart';
import 'package:flutter_focus_fun_tv_demo/slides/widgets/markdown_text.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// A widget that renders a list of BulletPoint objects as a formatted list.
class BulletListWidget extends StatelessWidget {
  final List<BulletPoint> bullets;

  const BulletListWidget({super.key, required this.bullets});

  @override
  Widget build(BuildContext context) {
    final titleFontSize = 24.0;

    return Column(
      spacing: 24.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children:
          bullets.map((bullet) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    color: AppColors.contentBody,
                    height: 1.5,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MarkdownBody(
                        data: bullet.title,
                        styleSheet: _headerStyle,
                      ),
                      if (bullet.description != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: MarkdownText(text: bullet.description!),
                        ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }
}

final _headerStyle = MarkdownStyleSheet(
  p: TextStyle(
    fontSize: 28.0,
    color: AppColors.amber1,
    fontWeight: FontWeight.bold,
    height: 1.5,
    shadows: [Shadow(blurRadius: 2.0, color: AppColors.textShadow)],
  ),
  code: TextStyle(
    fontSize: 26.0,
    color: AppColors.amber1.withValues(alpha: 0.75),
    fontWeight: FontWeight.bold,
    fontFamily: 'monospace',
  ),
);
