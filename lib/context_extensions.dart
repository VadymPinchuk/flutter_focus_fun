import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun_tv_demo/model/page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/model/tv_settings_model.dart';
import 'package:provider/provider.dart';

extension Models on BuildContext {
  TvSettingsModel get settingsModel =>
      Provider.of<TvSettingsModel>(this, listen: false);

  PageUiModel get pageUiModel => Provider.of<PageUiModel>(this, listen: false);
}
