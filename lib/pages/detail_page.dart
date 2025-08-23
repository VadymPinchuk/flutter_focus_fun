import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/background_image.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/dynamic_background.dart';

class DetailPage extends StatelessWidget {
  final ContentItem item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        children: [BackgroundImage(), DynamicBackground(focusedItem: item)],
      ),
    );
  }
}
