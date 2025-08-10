import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/app/mobile_app.dart';
import 'package:flutter_focus_fun_tv_demo/app/tv_app.dart';
import 'package:flutter_focus_fun_tv_demo/model/page_scroll_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/model/tv_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/shortcuts/keyboard_shortcuts.dart';
import 'package:flutter_focus_fun_tv_demo/utils/ui_experience.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/background_image.dart';
import 'package:provider/provider.dart';

// --- Main Application ---
void main() {
  runApp(const PresentationApp());
}

class PresentationApp extends StatelessWidget {
  const PresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final uiExperience = defaultExperienceFor(platform);

    return Provider<UiExperience>.value(
      value: uiExperience,
      child: MaterialApp(
        title: 'Flutter Focus Fun',
        debugShowCheckedModeBanner: false,
        shortcuts: KeyboardShortcuts(uiExperience: uiExperience).shortcuts(),
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey.shade900,
          scaffoldBackgroundColor: Colors.transparent,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white70),
          ),
        ),
        home: Material(
          color: Colors.transparent,
          child: const Stack(children: [BackgroundImage(), AppShell()]),
        ),
      ),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late final PageController _pageController;
  int _selectedIndex = 0;

  late final List<PageScrollUiModel> _pageScrollStates;
  static const int _pageCount = 3;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageScrollStates = List.generate(_pageCount, (_) => PageScrollUiModel());
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final state in _pageScrollStates) {
      state.dispose();
    }
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    if (_selectedIndex == index) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final uiExperience = context.watch<UiExperience>();
    final bool isTvUI = uiExperience.isTv;

    final child =
        isTvUI
            ? Provider(
              create: (_) => TvUiModel(),
              child: TvApp(
                pageController: _pageController,
                selectedIndex: _selectedIndex,
                onNavItemTapped: _onNavItemTapped,
                onPageChanged: _onPageChanged,
                pageScrollStates: _pageScrollStates,
              ),
            )
            : MobileApp(
              pageController: _pageController,
              selectedIndex: _selectedIndex,
              onNavItemTapped: _onNavItemTapped,
              onPageChanged: _onPageChanged,
              pageScrollStates: _pageScrollStates,
            );

    return isTvUI ? child : SafeArea(child: child);
  }
}
