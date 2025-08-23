import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun_tv_demo/responsive/rail_data.dart';

class RailDataProvider extends InheritedWidget {
  final RailData themeData;

  const RailDataProvider({
    super.key,
    required this.themeData,
    required super.child,
  });

  static RailData of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<RailDataProvider>();
    return widget!.themeData;
  }

  @override
  bool updateShouldNotify(covariant RailDataProvider oldWidget) {
    return themeData != oldWidget.themeData;
  }
}
