import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/utils/ui_experience.dart';
import 'package:provider/provider.dart';

extension Experience on BuildContext {
  UiExperience get uiExperience =>
      Provider.of<UiExperience>(this, listen: false);

  TargetPlatform get platform => Theme.of(this).platform;
}
