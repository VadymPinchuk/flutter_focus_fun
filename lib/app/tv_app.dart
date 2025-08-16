import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/app/header/left_nav_rail.dart';
import 'package:flutter_focus_fun_tv_demo/app/header/top_nav_rail.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/model/page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/model/tv_screen_model.dart';
import 'package:flutter_focus_fun_tv_demo/pages/current/current_page.dart';
import 'package:flutter_focus_fun_tv_demo/pages/intro/intro_page.dart';
import 'package:flutter_focus_fun_tv_demo/pages/resolution/resolution_page.dart';
import 'package:flutter_focus_fun_tv_demo/pages/summary_page.dart';
import 'package:flutter_focus_fun_tv_demo/scaffold/home_page_scaffold.dart';
import 'package:flutter_focus_fun_tv_demo/scaffold/tv_screen_scaffold.dart';
import 'package:provider/provider.dart';

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
    Widget pageView = PageView(
      controller: pageController,
      onPageChanged: onPageChanged,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ChangeNotifierProvider.value(
          value: pageModels[0],
          child: const CurrentPage(),
        ),
        ChangeNotifierProvider.value(
          value: pageModels[1],
          child: const IntroPage(),
        ),
        ChangeNotifierProvider.value(
          value: pageModels[2],
          child: const ResolutionPage(),
        ),
        ChangeNotifierProvider.value(
          value: pageModels[3],
          child: const SummaryPage(),
        ),
      ],
    );

    return HomePageScaffold(
      pageController: pageController,
      selectedIndex: selectedIndex,
      onNavItemTapped: onNavItemTapped,
      onPageChanged: onPageChanged,
      pageModels: pageModels,
    );
    return TvScreenScaffold(
      body: pageView,
      header: ValueListenableBuilder<TvNavBarLocation>(
        valueListenable: context.tvScreenModel.navBarLocation,
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
