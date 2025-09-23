import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/app_colors.dart';
import 'package:flutter_focus_fun_tv_demo/app_strings.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: 8.0,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppStrings.talkTitle,
          style: TextStyle(
            color: theme.textTheme.bodyLarge!.color,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        Text(
          'by',
          style: TextStyle(
            color: theme.textTheme.bodyLarge!.color!.withValues(alpha: 0.8),
            fontSize: 18.0,
          ),
        ),
        Image.asset(
          'assets/images/hat.png',
          height: 42,
          errorBuilder:
              (c, e, s) =>
                  Icon(Icons.person, color: theme.textTheme.bodyLarge!.color!),
        ),
        Text(
          'for',
          style: TextStyle(
            color: theme.textTheme.bodyLarge!.color!.withValues(alpha: 0.8),
            fontSize: 18.0,
          ),
        ),
        Image.asset(
          'assets/images/flutter_community.png',
          height: 56,
          errorBuilder:
              (c, e, s) =>
                  Icon(Icons.groups, color: theme.textTheme.bodyLarge!.color),
        ),
      ],
    );
  }
}
