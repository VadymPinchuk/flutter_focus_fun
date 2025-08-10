import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_focus_fun_tv_demo/model/page_scroll_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/pages/intro_page.dart';
import 'package:flutter_focus_fun_tv_demo/pages/resolution_page.dart';
import 'package:flutter_focus_fun_tv_demo/pages/summary_page.dart';

class MobileApp extends StatelessWidget {
  final PageController pageController;
  final int selectedIndex;
  final ValueChanged<int> onNavItemTapped;
  final ValueChanged<int> onPageChanged;
  final List<PageScrollUiModel> pageScrollStates;

  const MobileApp({
    super.key,
    required this.pageController,
    required this.selectedIndex,
    required this.onNavItemTapped,
    required this.onPageChanged,
    required this.pageScrollStates,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900]!,
      body: PageView(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey[900]!,
        currentIndex: selectedIndex,
        onTap: onNavItemTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 0 ? Icons.help : Icons.help_outline),
            label: 'Intro',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 1 ? Icons.lightbulb : Icons.lightbulb_outline,
            ),
            label: 'Resolution',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 2
                  ? Icons.assignment_turned_in
                  : Icons.assignment_turned_in_outlined,
            ),
            label: 'Summary',
          ),
        ],
      ),
    );
  }
}
