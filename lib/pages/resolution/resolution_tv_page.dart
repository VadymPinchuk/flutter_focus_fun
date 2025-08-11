import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/mock_rail_data.dart'
    show mockData;
import 'package:flutter_focus_fun_tv_demo/grid_traversal_policy.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/body_widget.dart';

class TvResolutionPage extends StatelessWidget {
  const TvResolutionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: GridTraversalPolicy(),
      child: BodyWidget(rails: mockData.skip(3).toList()),
    );
  }
}
