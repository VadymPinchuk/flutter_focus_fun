import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun_tv_demo/app_colors.dart';
import 'package:flutter_focus_fun_tv_demo/slides/widgets/bullet_list_widget.dart';

class BodyTextWidget extends StatelessWidget {
  final List<String>? bullets;
  final String? plainText;

  const BodyTextWidget({super.key, this.bullets, this.plainText});

  @override
  Widget build(BuildContext context) {
    if (plainText != null) {
      return Text(
        plainText!,
        style: const TextStyle(
          fontSize: 24.0,
          height: 1.5,
          color: AppColors.contentBody,
        ),
      );
    }
    if (bullets != null) {
      return BulletListWidget(bullets: bullets!);
    }
    return const SizedBox.shrink();
  }
}
