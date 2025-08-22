import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_focus_fun_tv_demo/model/settings_model.dart';
import 'package:flutter_focus_fun_tv_demo/scaffold/screen_scaffold.dart';
import 'package:flutter_focus_fun_tv_demo/shortcuts/keyboard_shortcuts.dart';
import 'package:flutter_focus_fun_tv_demo/utils/ui_experience.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/background_image.dart';
import 'package:provider/provider.dart';

// --- Main Application ---
void main() {
  runApp(const PresentationApp());
}

class PresentationApp extends StatefulWidget {
  const PresentationApp({super.key});

  @override
  State<PresentationApp> createState() => _PresentationAppState();
}

class _PresentationAppState extends State<PresentationApp> {
  final SettingsModel settingsModel = SettingsModel();

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (event) {
          print('Key event: ${event.runtimeType} - ${event.logicalKey}');
        },
        child: MultiProvider(
          providers: [
            Provider<SettingsModel>.value(value: settingsModel),
            Provider<UiExperience>.value(value: uiExperience),
          ],
          child: ValueListenableBuilder(
            valueListenable: settingsModel.textScaleFactor,
            builder: (ctx, textScale, _) {
              final mediaQueryData = MediaQuery.of(ctx);
              return MediaQuery(
                data: mediaQueryData.copyWith(
                  textScaler: TextScaler.linear(textScale),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: const Stack(
                    children: [BackgroundImage(), ScreenScaffold()],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
