import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/slides/slide_widget.dart';
import 'package:flutter_focus_fun_tv_demo/utils/scope_functions.dart';

class DynamicBackground extends StatelessWidget {
  const DynamicBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.pageUiModel.focusedItem,
      builder: (_, focusedItem, __) {
        if (focusedItem == null) return const SizedBox.shrink();
        if (focusedItem.slideAssetPath.isNotEmpty) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: SlideWidget(
              key: ValueKey(focusedItem.slideAssetPath),
              jsonAssetPath: focusedItem.slideAssetPath,
            ),
          );
        }
        return Stack(
          fit: StackFit.expand,
          children: [
            // This AnimatedSwitcher will smoothly transition between background images.
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: focusedItem.letOrDefault(
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
            // This gradient is drawn on top of the image to ensure text is readable.
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.6),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
            // The text content is positioned on top of the gradient.
            Positioned(
              top: 150,
              left: 48,
              right: 48,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: focusedItem.letOrDefault(
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
                          shadows: [
                            Shadow(blurRadius: 4, color: Colors.black54),
                          ],
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
      },
    );
  }
}
