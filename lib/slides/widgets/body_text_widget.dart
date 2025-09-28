import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun/data_models/bullet_point.dart';
import 'package:flutter_focus_fun/slides/widgets/body_text.dart';
import 'package:flutter_focus_fun/slides/widgets/bullet_list_widget.dart';

class BodyTextWidget extends StatelessWidget {
  final List<BulletPoint>? bullets;
  final List<String>? plainText;

  const BodyTextWidget({super.key, this.bullets, this.plainText});

  @override
  Widget build(BuildContext context) {
    final textEntities = plainText;
    if (textEntities != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0,
        children: textEntities.map((text) => BodyText(text)).toList(),
      );
    }
    if (bullets != null) {
      return BulletListWidget(bullets: bullets!);
    }
    return const SizedBox.shrink();
  }
}
