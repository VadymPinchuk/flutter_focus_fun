import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_focus_fun_tv_demo/model/page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/model/tv_settings_model.dart';
import 'package:flutter_focus_fun_tv_demo/scaffold/screen_scaffold.dart';
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    final platform = Theme.of(context).platform;
    final uiExperience = defaultExperienceFor(platform);

    return MaterialApp(
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
      home: MultiProvider(
        providers: [
          Provider<TvSettingsModel>(create: (_) => TvSettingsModel()),
          Provider<UiExperience>.value(value: uiExperience),
        ],
        child: Material(
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

  late final List<PageUiModel> _pageModels;
  static const int _pageCount = 4;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageModels = List.generate(_pageCount, (_) => PageUiModel());
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final state in _pageModels) {
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
    return ScreenScaffold(
      pageController: _pageController,
      selectedIndex: _selectedIndex,
      onNavItemTapped: _onNavItemTapped,
      onPageChanged: _onPageChanged,
      pageModels: _pageModels,
    );
  }
}
