import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/pages/resolution/resolution_mobile_page.dart';
import 'package:flutter_focus_fun_tv_demo/pages/resolution/resolution_tv_page.dart';
import 'package:flutter_focus_fun_tv_demo/utils/ui_experience.dart';
import 'package:provider/provider.dart';

class ResolutionPage extends StatelessWidget {
  const ResolutionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return switch (context.read<UiExperience>()) {
      UiExperience.mobile => const MobileResolutionPage(),
      UiExperience.tv => const TvResolutionPage(),
    };
  }
}
