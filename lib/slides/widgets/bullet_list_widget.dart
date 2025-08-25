import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/app_colors.dart';
import 'package:flutter_focus_fun_tv_demo/data_models/bullet_point.dart';

/// A widget that renders a list of BulletPoint objects as a formatted list.
class BulletListWidget extends StatelessWidget {
  final List<BulletPoint> bullets;

  const BulletListWidget({super.key, required this.bullets});

  @override
  Widget build(BuildContext context) {
    final titleFontSize = 24.0;
    final descriptionFontSize = 22.0;

    return Column(
      spacing: 24.0,
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    height: 1.2,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bullet.title,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          color: AppColors.contentBody,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      if (bullet.description != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            bullet.description!,
                            style: TextStyle(
                              fontSize: descriptionFontSize,
                              color: AppColors.contentBody.withValues(
                                alpha: 0.8,
                              ),
                              height: 1.2,
                            ),
                          ),
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
