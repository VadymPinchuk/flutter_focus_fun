import 'package:flutter/foundation.dart' show TargetPlatform;

enum UiExperience {
  mobile,
  tv;

  bool get isTv => this == UiExperience.tv;

  bool get isMobile => this == UiExperience.mobile;
}

UiExperience defaultExperienceFor(TargetPlatform p) => switch (p) {
  TargetPlatform.fuchsia ||
  TargetPlatform.android ||
  TargetPlatform.iOS => UiExperience.mobile,
  TargetPlatform.linux ||
  TargetPlatform.macOS ||
  TargetPlatform.windows => UiExperience.tv,
};
