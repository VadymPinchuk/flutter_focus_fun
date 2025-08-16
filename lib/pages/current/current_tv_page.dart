import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/mock_rail_data.dart'
    show mockConfData;
import 'package:flutter_focus_fun_tv_demo/widgets/body_widget.dart';

class TvCurrentPage extends StatelessWidget {
  const TvCurrentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyWidget(rails: mockConfData);
  }
}
