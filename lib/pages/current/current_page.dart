import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/pages/current/current_mobile_page.dart';
import 'package:flutter_focus_fun_tv_demo/pages/current/current_tv_page.dart';
import 'package:flutter_focus_fun_tv_demo/utils/ui_experience.dart';
import 'package:provider/provider.dart';

class CurrentPage extends StatelessWidget {
  const CurrentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return switch (context.read<UiExperience>()) {
      UiExperience.mobile => const MobileCurrentPage(),
      UiExperience.tv => const TvCurrentPage(),
    };
  }
}
