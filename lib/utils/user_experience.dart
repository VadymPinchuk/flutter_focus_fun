import 'package:flutter/foundation.dart' show TargetPlatform;

enum UserExperience {
  mobile,
  tv;

  bool get isTv => this == UserExperience.tv;

  bool get isMobile => this == UserExperience.mobile;
}

UserExperience defaultExperienceFor(TargetPlatform p) => switch (p) {
  TargetPlatform.fuchsia ||
  TargetPlatform.android ||
  TargetPlatform.iOS => UserExperience.mobile,
  TargetPlatform.linux ||
  TargetPlatform.macOS ||
  TargetPlatform.windows => UserExperience.tv,
};
