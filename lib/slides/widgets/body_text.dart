import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun_tv_demo/app_colors.dart';

class BodyText extends StatelessWidget {
  final String text;

  const BodyText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 24.0,
        height: 1.5,
        color: AppColors.contentBody,
      ),
    );
  }
}
