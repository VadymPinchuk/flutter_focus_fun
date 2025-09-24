import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_rail_data.dart';
import 'package:flutter_focus_fun_tv_demo/model/page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/theme/background_gradient_theme.dart';
import 'package:flutter_focus_fun_tv_demo/utils/user_experience.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/background_image.dart';
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
    return Stack(
      children: [
        BackgroundImage(colors: context.backGradient),
        ValueListenableBuilder(
          valueListenable: context.settingsModel.experience,
          builder:
              (_, experience, _) => switch (experience) {
                UserExperience.tv => BodyWidget(rails: _railsData),
                UserExperience.mobile => CustomScrollView(
                  controller: _verticalScrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.paddingOf(context).top,
                      ),
                    ),
                    ..._railsData.indexed.map((railData) {
                      return MobileContentRail(
                        index: railData.$1,
                        data: railData.$2,
                        horizontalController: _pageModel
                            .getHorizontalController(railData.$2.id),
                      );
                    }),
                    const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.paddingOf(context).bottom,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: kBottomNavigationBarHeight),
                    ),
                  ],
                ),
              },
        ),
      ],
    );
  }
}

extension on BuildContext {
  List<Color>? get backGradient =>
      Theme.of(this).extension<BackgroundGradientTheme>()?.colors;
}
