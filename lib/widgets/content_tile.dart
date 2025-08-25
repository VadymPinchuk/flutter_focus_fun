import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/app_colors.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';
import 'package:flutter_focus_fun_tv_demo/pages/detail_page.dart';
import 'package:flutter_focus_fun_tv_demo/utils/scope_functions.dart';

class ContentTile extends StatelessWidget {
  final String index;
  final ContentItem item;

  const ContentTile({super.key, required this.index, required this.item});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (_, _, _) => DetailPage(item: item),
                transitionsBuilder: (_, animation, _, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                transitionDuration: const Duration(milliseconds: 300),
              ),
            );
          },
          child: Container(
            color: item.color,
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: item.icon.letOrElse(
                    (icon) => Icon(
                      item.icon,
                      size: 36.0,
                      color: AppColors.tileIcon,
                      shadows: [
                        Shadow(blurRadius: 2.0, color: AppColors.tileTitle),
                      ],
                    ),
                    orElse:
                        () => Text(
                          index,
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          style: const TextStyle(
                            color: AppColors.tileTitle,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            shadows: [
                              Shadow(
                                blurRadius: 2.0,
                                color: AppColors.tileShadow,
                              ),
                            ],
                          ),
                        ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: const TextStyle(
                        color: AppColors.tileTitle,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        shadows: [
                          Shadow(blurRadius: 2.0, color: AppColors.tileShadow),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.tileDescription,
                        fontSize: 12,
                        shadows: const [
                          Shadow(blurRadius: 2.0, color: AppColors.tileShadow),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
