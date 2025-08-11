import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun_tv_demo/model/tv_page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/model/tv_ui_model.dart';
import 'package:provider/provider.dart';

extension Models on BuildContext {
  TvUiModel get tvUiModel => read<TvUiModel>();

  TvPageUiModel get tvPageUiModel => read<TvPageUiModel>();
}
