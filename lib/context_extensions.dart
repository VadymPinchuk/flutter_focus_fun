import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun_tv_demo/model/page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/model/tv_screen_model.dart';
import 'package:provider/provider.dart';

extension Models on BuildContext {
  TvScreenModel get tvScreenModel =>
      Provider.of<TvScreenModel>(this, listen: false);

  PageUiModel get pageUiModel => Provider.of<PageUiModel>(this, listen: false);
}
