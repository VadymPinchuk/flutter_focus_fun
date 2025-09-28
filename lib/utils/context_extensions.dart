import 'package:flutter/material.dart';
import 'package:flutter_focus_fun/utils/user_experience.dart';
import 'package:provider/provider.dart';

extension Experience on BuildContext {
  UserExperience get experience =>
      Provider.of<UserExperience>(this, listen: false);

  TargetPlatform get platform => Theme.of(this).platform;
}
