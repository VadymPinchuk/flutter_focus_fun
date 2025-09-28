import 'package:flutter/material.dart';
import 'package:flutter_focus_fun/data/content_item.dart';
import 'package:flutter_focus_fun/theme/background_gradient_theme.dart';
import 'package:flutter_focus_fun/widgets/background_image.dart';
import 'package:flutter_focus_fun/widgets/dynamic_content.dart';

class DetailPage extends StatelessWidget {
  final ContentItem item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 72.0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(Icons.close_outlined, color: Colors.white, size: 32),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          BackgroundImage(colors: context.backGradient),
          DynamicContent(focusedItem: item),
        ],
      ),
    );
  }
}

extension on BuildContext {
  List<Color>? get backGradient =>
      Theme.of(this).extension<BackgroundGradientTheme>()?.colors;
}
