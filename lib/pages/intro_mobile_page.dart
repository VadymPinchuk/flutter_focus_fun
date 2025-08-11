import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/mock_rail_data.dart'
    show ContentRailData, mockData;
import 'package:flutter_focus_fun_tv_demo/model/tv_page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/mobile_rail.dart';
import 'package:provider/provider.dart';

class MobileIntroPage extends StatefulWidget {
  const MobileIntroPage({super.key});

  @override
  State<MobileIntroPage> createState() => _MobileIntroPageState();
}

class _MobileIntroPageState extends State<MobileIntroPage> {
  late final ScrollController _verticalScrollController;
  late final TvPageUiModel _scrollState;
  final List<ContentRailData> _introRails = mockData.take(3).toList();

  @override
  void initState() {
    super.initState();
    _scrollState = context.read<TvPageUiModel>();
    _verticalScrollController = ScrollController(
      initialScrollOffset: _scrollState.verticalOffset,
    );
    _verticalScrollController.addListener(() {
      _scrollState.setVerticalOffset(_verticalScrollController.offset);
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
            horizontalController: _scrollState.getHorizontalController(
              railData.id,
            ),
          );
        }),
        const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
      ],
    );
  }
}
