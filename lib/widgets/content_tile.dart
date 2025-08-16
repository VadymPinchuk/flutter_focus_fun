import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';
import 'package:flutter_focus_fun_tv_demo/pages/mobile_detail_page.dart';

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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MobileDetailPage(item: item),
              ),
            );
          },
          child: Container(
            color: item.color,
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Center(child: Icon(item.icon, size: 48, color: Colors.white)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        shadows: [
                          Shadow(blurRadius: 2.0, color: Colors.black54),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                        shadows: const [
                          Shadow(blurRadius: 2.0, color: Colors.black54),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
