import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun/context_extensions.dart';
import 'package:flutter_focus_fun/responsive/rail_data_provider.dart';
import 'package:flutter_focus_fun/utils/user_experience.dart';

import 'rail_data.dart';

class ResponsiveDataWidget extends StatelessWidget {
  final UserExperience experience;

  final RailData Function(UserExperience, double, double, double) railData;
  final WidgetBuilder builder;

  const ResponsiveDataWidget({
    super.key,
    required this.experience,
    required this.railData,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return ValueListenableBuilder(
      valueListenable: context.settingsModel.tilesPerRowCount,
      builder: (_, tilesCount, _) {
        final textScale = context.textScale;
        return RailDataProvider(
          themeData: railData(experience, screenWidth, tilesCount, textScale),
          child: Builder(builder: builder),
        );
      },
    );
  }
}
