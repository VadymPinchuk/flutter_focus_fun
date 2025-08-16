import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/model/page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/scaffold/screen_scaffold.dart';

class TvApp extends StatelessWidget {
  final PageController pageController;
  final int selectedIndex;
  final ValueChanged<int> onNavItemTapped;
  final ValueChanged<int> onPageChanged;
  final List<PageUiModel> pageModels;

  const TvApp({
    super.key,
    required this.pageController,
    required this.selectedIndex,
    required this.onNavItemTapped,
    required this.onPageChanged,
    required this.pageModels,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      pageController: pageController,
      selectedIndex: selectedIndex,
      onNavItemTapped: onNavItemTapped,
      onPageChanged: onPageChanged,
      pageModels: pageModels,
    );
  }
}
