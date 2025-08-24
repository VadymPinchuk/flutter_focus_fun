import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_focus_fun_tv_demo/data_models/slide_data.dart';
import 'package:flutter_focus_fun_tv_demo/data_models/slide_types.dart';
import 'package:flutter_focus_fun_tv_demo/slides/slide_layouts.dart';

class SlideWidget extends StatelessWidget {
  final String jsonAssetPath;

  const SlideWidget({super.key, required this.jsonAssetPath});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: rootBundle.loadString(jsonAssetPath),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final slideData = SlideData.fromJson(json.decode(snapshot.data!));
        // Use a switch statement to build the correct layout based on slideType.
        switch (slideData.slideType) {
          case SlideType.plainText:
          case SlideType.singleText:
            return SingleTextLayout(data: slideData);
          case SlideType.doubleText:
            return DoubleTextLayout(data: slideData);
          case SlideType.leftTextRightImage:
            return LeftTextRightImageLayout(data: slideData);
          case SlideType.leftTextRightCode:
            return LeftTextRightCodeLayout(data: slideData);
          case SlideType.leftImageRightText:
            return LeftImageRightTextLayout(data: slideData);
          case SlideType.leftImageRightCode:
            return LeftImageRightCodeLayout(data: slideData);
          case SlideType.leftCodeRightImage:
            return LeftCodeRightImageLayout(data: slideData);
          case SlideType.singleCode:
            return SingleCodeLayout(data: slideData);
          case SlideType.doubleCode:
            return DoubleCodeLayout(data: slideData);
          case SlideType.textWithCode:
            return TextWithCodeLayout(data: slideData);
          case SlideType.unknown:
            return Center(
              child: Text(
                'Unknown or invalid slide type: ${slideData.slideType}',
              ),
            );
        }
      },
    );
  }
}
