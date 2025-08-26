import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_focus_fun_tv_demo/model/settings_model.dart';
import 'package:flutter_focus_fun_tv_demo/responsive/rail_data.dart';
import 'package:flutter_focus_fun_tv_demo/responsive/responsive_data_widget.dart';
import 'package:flutter_focus_fun_tv_demo/scaffold/screen_scaffold.dart';
import 'package:flutter_focus_fun_tv_demo/shortcuts/keyboard_shortcuts.dart';
import 'package:flutter_focus_fun_tv_demo/tools/focus_debugger.dart';
import 'package:flutter_focus_fun_tv_demo/utils/user_experience.dart';
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
    final experience = defaultExperienceFor(platform);

    return MultiProvider(
      providers: [
        Provider<SettingsModel>.value(value: settingsModel),
        Provider<UserExperience>.value(value: experience),
      ],
      child: ValueListenableBuilder(
        valueListenable: settingsModel.textScaleFactor,
        builder:
            (ctx, textScale, _) => MediaQuery(
              data: MediaQuery.of(
                ctx,
              ).copyWith(textScaler: TextScaler.linear(textScale)),
              child: ResponsiveDataWidget(
                experience: experience,
                railData: RailData.forExperience,
                builder:
                    (ctx) => CallbackShortcuts(
                      bindings: {
                        // LogicalKeySet(LogicalKeyboardKey.digit1): () {
                        //   settingsModel.toggleUiExperience();
                        // },
                        // LogicalKeySet(LogicalKeyboardKey.digit2): () {
                        //   settingsModel.toggleFocusDecoration();
                        // },
                        // LogicalKeySet(LogicalKeyboardKey.digit3): () {
                        //   settingsModel.toggleTvPageLayout();
                        // },
                        // LogicalKeySet(LogicalKeyboardKey.digit4): () {
                        //   settingsModel.toggleTraversalPolicy();
                        // },
                        LogicalKeySet(LogicalKeyboardKey.digit9): () {
                          FocusDebugger.instance.toggleIt();
                        },
                      },
                      child: MaterialApp(
                        title: 'Flutter Focus Fun',
                        debugShowCheckedModeBanner: false,
                        shortcuts:
                            KeyboardShortcuts(
                              experience: experience,
                            ).shortcuts(),
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
                        home: Material(
                          color: Colors.transparent,
                          child: const Stack(
                            children: [BackgroundImage(), ScreenScaffold()],
                          ),
                        ),
                      ),
                    ),
              ),
            ),
      ),
    );
  }
}
