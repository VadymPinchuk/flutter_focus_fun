import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/app_colors.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';
import 'package:flutter_focus_fun_tv_demo/pages/detail_page.dart';

class ContentTile extends StatelessWidget {
  final ContentItem item;

  const ContentTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => DetailPage(item: item)));
          },
          child: Container(
            color: item.color,
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Icon(
                    item.icon,
                    size: 36.0,
                    color: AppColors.tileIcon,
                    shadows: [
                      Shadow(blurRadius: 2.0, color: AppColors.tileTitle),
                    ],
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
