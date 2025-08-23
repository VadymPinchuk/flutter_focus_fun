import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';
import 'package:flutter_focus_fun_tv_demo/slides/slide_widget.dart';
import 'package:flutter_focus_fun_tv_demo/utils/scope_functions.dart';

class DynamicBackground extends StatelessWidget {
  final ContentItem? focusedItem;

  const DynamicBackground({super.key, this.focusedItem});

  @override
  Widget build(BuildContext context) {
    final dataItem = focusedItem;
    if (dataItem == null) return const SizedBox.shrink();
    if (dataItem.slideAssetPath.isNotEmpty) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: SlideWidget(
          key: ValueKey(dataItem.slideAssetPath),
          jsonAssetPath: dataItem.slideAssetPath,
        ),
      );
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        // This AnimatedSwitcher will smoothly transition between background images.
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: dataItem.letOrDefault(
            (item) => ShaderMask(
              // This mask applies a radial gradient to fade the edges.
              shaderCallback:
                  (bounds) => const RadialGradient(
                    center: Alignment(0.7, -0.7),
                    // Center is shifted to the top-right
                    radius: 1.2,
                    colors: [Colors.white, Colors.transparent],
                    stops: [0.4, 1.0],
                  ).createShader(bounds),
              blendMode: BlendMode.dstIn,
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    key: ValueKey<String>(item.imagePath),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(item.imagePath),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {},
                      ),
                    ),
                  ),
                ),
              ),
            ),
            orElse: const SizedBox.shrink(),
          ),
        ),

        // The text content is positioned on top of the gradient.
        Positioned(
          top: 150,
          left: 48,
          right: 48,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: dataItem.letOrDefault(
              (item) => Column(
                key: ValueKey<String>(item.title),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    item.description,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white.withValues(alpha: 0.9),
                      shadows: const [
                        Shadow(blurRadius: 2, color: Colors.black54),
                      ],
                    ),
                  ),
                ],
              ),
              orElse: const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    );
  }
}
