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
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image is the base layer
              Image.asset(
                item.imagePath,
                fit: BoxFit.cover,
                // Error handling for missing assets
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[800],
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.white54,
                      ),
                    ),
                  );
                },
              ),
              // Gradient overlay for text readability
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),
              // Text is positioned at the bottom
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 2.0, color: Colors.black87)],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
