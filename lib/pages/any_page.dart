import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/data/mock_rail_data.dart';
import 'package:flutter_focus_fun_tv_demo/model/page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/utils/ui_experience.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/body_widget.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/mobile_rail.dart';

class AnyPage extends StatefulWidget {
  const AnyPage({super.key});

  @override
  State<AnyPage> createState() => _AnyPageState();
}

class _AnyPageState extends State<AnyPage> {
  late final ScrollController _verticalScrollController;
  late final PageUiModel _pageModel;
  late final List<ContentRailData> _railsData;

  @override
  void initState() {
    super.initState();
    _pageModel = context.pageUiModel;
    _railsData = _pageModel.railsData;
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
    return ValueListenableBuilder(
      valueListenable: context.settingsModel.uiExperience,
      builder:
          (_, uiExperience, _) => switch (uiExperience) {
            UiExperience.tv => BodyWidget(rails: _railsData),
            UiExperience.mobile => CustomScrollView(
              controller: _verticalScrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(height: MediaQuery.paddingOf(context).top),
                ),
                ..._railsData.map((railData) {
                  return MobileContentRail(
                    data: railData,
                    horizontalController: _pageModel.getHorizontalController(
                      railData.id,
                    ),
                  );
                }),
                const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
                SliverToBoxAdapter(
                  child: SizedBox(height: MediaQuery.paddingOf(context).bottom),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: kBottomNavigationBarHeight),
                ),
              ],
            ),
          },
    );
  }
}
