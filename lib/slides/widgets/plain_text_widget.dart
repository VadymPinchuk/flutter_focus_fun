import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';

/// A widget that renders a single block of text with a larger font size.
class PlainTextWidget extends StatelessWidget {
  final List<String> text;

  const PlainTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          text
              .map(
                (line) => Text(
                  line,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
              )
              .toList(),
    );
  }
}
