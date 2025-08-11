import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/pages/intro/intro_mobile_page.dart';
import 'package:flutter_focus_fun_tv_demo/pages/intro/intro_tv_page.dart';
import 'package:flutter_focus_fun_tv_demo/utils/ui_experience.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return switch (context.read<UiExperience>()) {
      UiExperience.mobile => const MobileIntroPage(),
      UiExperience.tv => const TvIntroPage(),
    };
  }
}
