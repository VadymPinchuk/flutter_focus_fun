import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/data/mock_rail_data.dart'
    show ContentRailData, mockData;
import 'package:flutter_focus_fun_tv_demo/model/page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/mobile_rail.dart';

class MobileIntroPage extends StatefulWidget {
  const MobileIntroPage({super.key});

  @override
  State<MobileIntroPage> createState() => _MobileIntroPageState();
}

class _MobileIntroPageState extends State<MobileIntroPage> {
  late final ScrollController _verticalScrollController;
  late final PageUiModel _pageModel;
  final List<ContentRailData> _introRails = mockData.take(3).toList();

  @override
  void initState() {
    super.initState();
    _pageModel = context.pageUiModel;
    _verticalScrollController = ScrollController(
      initialScrollOffset: _pageModel.verticalOffset,
    );
    _verticalScrollController.addListener(() {
      _pageModel.setVerticalOffset(_verticalScrollController.offset);
    });
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _verticalScrollController,
      slivers: [
        const SliverPadding(padding: EdgeInsets.only(top: 24)),
        ..._introRails.map((railData) {
          return MobileContentRail(
            data: railData,
            horizontalController: _pageModel.getHorizontalController(
              railData.id,
            ),
          );
        }),
        const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
      ],
    );
  }
}
