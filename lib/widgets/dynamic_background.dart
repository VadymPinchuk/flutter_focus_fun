import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/utils/scope_functions.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/background_image.dart';

class DynamicBackground extends StatelessWidget {
  const DynamicBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.pageUiModel.focusedItem,
      builder:
          (_, focusedItem, __) => Stack(
            children: [
              focusedItem.letOrDefault(
                (it) => AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  color: it.color,
                ),
                orElse: BackgroundImage(),
              ),
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
              Positioned(
                top: 150,
                left: 48,
                right: 48,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: focusedItem.letOrDefault(
                    (it) => Column(
                      key: ValueKey<String>(it.title),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          it.title,
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
                          it.description,
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
          ),
    );
  }
}
