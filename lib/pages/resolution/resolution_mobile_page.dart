import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/mock_rail_data.dart'
    show ContentRailData, mockData;
import 'package:flutter_focus_fun_tv_demo/model/page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/mobile_rail.dart';
import 'package:provider/provider.dart';

class MobileResolutionPage extends StatefulWidget {
  const MobileResolutionPage({super.key});

  @override
  State<MobileResolutionPage> createState() => _MobileResolutionPageState();
}

class _MobileResolutionPageState extends State<MobileResolutionPage> {
  late final ScrollController _verticalScrollController;
  late final PageUiModel pageModel;
  final List<ContentRailData> _resolutionRails = mockData.skip(3).toList();

  @override
  void initState() {
    super.initState();
    pageModel = context.read<PageUiModel>();
    _verticalScrollController = ScrollController(
      initialScrollOffset: pageModel.verticalOffset,
    );
    _verticalScrollController.addListener(() {
      pageModel.setVerticalOffset(_verticalScrollController.offset);
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
        ..._resolutionRails.map((railData) {
          return MobileContentRail(
            data: railData,
            horizontalController: pageModel.getHorizontalController(
              railData.id,
            ),
          );
        }),
        const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
      ],
    );
  }
}
