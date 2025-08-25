import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/app_colors.dart';

/// A widget that renders a list of strings as a formatted bullet list.
class BulletListWidget extends StatelessWidget {
  final List<String> bullets;

  const BulletListWidget({super.key, required this.bullets});

  @override
  Widget build(BuildContext context) {
    final fontSize = 24.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.0,
      children:
          bullets
              .map(
                (text) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ',
                      style: TextStyle(
                        fontSize: fontSize,
                        color: AppColors.contentBody,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: AppColors.contentBody,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
    );
  }
}
