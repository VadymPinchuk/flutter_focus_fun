import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/app/header/left_nav_rail.dart';
import 'package:flutter_focus_fun_tv_demo/app/header/top_nav_rail.dart';
import 'package:flutter_focus_fun_tv_demo/model/tv_page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/model/tv_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/pages/intro_page.dart';
import 'package:flutter_focus_fun_tv_demo/pages/resolution_page.dart';
import 'package:flutter_focus_fun_tv_demo/pages/summary_page.dart';
import 'package:flutter_focus_fun_tv_demo/scaffold/tv_screen_scaffold.dart';
import 'package:provider/provider.dart';

class TvApp extends StatelessWidget {
  final PageController pageController;
  final int selectedIndex;
  final ValueChanged<int> onNavItemTapped;
  final ValueChanged<int> onPageChanged;
  final List<TvPageUiModel> pageScrollStates;

  const TvApp({
    super.key,
    required this.pageController,
    required this.selectedIndex,
    required this.onNavItemTapped,
    required this.onPageChanged,
    required this.pageScrollStates,
  });

  @override
  Widget build(BuildContext context) {
    Widget pageView = PageView(
      controller: pageController,
      onPageChanged: onPageChanged,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ChangeNotifierProvider.value(
          value: pageScrollStates[0],
          child: const IntroPage(),
        ),
        ChangeNotifierProvider.value(
          value: pageScrollStates[1],
          child: const ResolutionPage(),
        ),
        ChangeNotifierProvider.value(
          value: pageScrollStates[2],
          child: const SummaryPage(),
        ),
      ],
    );

    return TvScreenScaffold(
      body: pageView,
      header: ValueListenableBuilder<TvNavBarLocation>(
        valueListenable: context.read<TvUiModel>().navBarLocation,
        builder:
            (_, location, _) => switch (location) {
              TvNavBarLocation.left => LeftNavRail(
                selectedIndex: selectedIndex,
                onTapped: onNavItemTapped,
              ),
              TvNavBarLocation.top => TopNavRail(
                selectedIndex: selectedIndex,
                onTapped: onNavItemTapped,
              ),
            },
      ),
    );
  }
}
