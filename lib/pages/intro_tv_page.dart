import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/mock_rail_data.dart'
    show mockData;
import 'package:flutter_focus_fun_tv_demo/widgets/body_widget.dart';

class TvIntroPage extends StatelessWidget {
  const TvIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyWidget(rails: mockData.take(4).toList());
  }
}
