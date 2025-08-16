import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/model/page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/model/settings_model.dart';
import 'package:provider/provider.dart';

extension Models on BuildContext {
  SettingsModel get settingsModel =>
      Provider.of<SettingsModel>(this, listen: false);

  PageUiModel get pageUiModel => Provider.of<PageUiModel>(this, listen: false);
}

extension SomeTheme on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
}
