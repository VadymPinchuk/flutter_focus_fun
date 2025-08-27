import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun_tv_demo/slides/widgets/markdown_text.dart';

class BodyText extends StatelessWidget {
  final String text;

  const BodyText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return MarkdownText(text: text);
  }
}
