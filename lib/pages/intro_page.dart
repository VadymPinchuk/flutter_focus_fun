import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/dynamic_background.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/mobile_rail.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/tv_rail.dart';
import 'package:provider/provider.dart';

import 'package:flutter_focus_fun_tv_demo/utils/ui_experience.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';
import 'package:flutter_focus_fun_tv_demo/data/mock_rail_data.dart'
    show ContentRailData, mockData;
import 'package:flutter_focus_fun_tv_demo/model/page_scroll_ui_model.dart';

import '../grid_traversal_policy.dart';

// --- Pages ---

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return switch (context.read<UiExperience>()) {
      UiExperience.mobile => const MobileIntroPage(),
      UiExperience.tv => const TvIntroPage(),
    };
  }
}

// --- TV Intro Page Implementation ---

class TvIntroPage extends StatefulWidget {
  const TvIntroPage({super.key});

  @override
  State<TvIntroPage> createState() => _TvIntroPageState();
}

class _TvIntroPageState extends State<TvIntroPage> {
  late final ScrollController _verticalScrollController;
  late final PageScrollUiModel _scrollState;
  final List<ContentRailData> _introRails = mockData.take(4).toList();
  static const double _kRailHeight =
      192.0; // Approximate height of a rail + padding

  @override
  void initState() {
    super.initState();
    _scrollState = context.read<PageScrollUiModel>();
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
    return Stack(
      children: [
        const DynamicBackground(),
        CustomScrollView(
          controller: _verticalScrollController,
          slivers: [
            const SliverPadding(padding: EdgeInsets.only(top: 600)),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final railData = _introRails[index];
                return TvRail(
                  data: railData,
                  railIndex: index,
                  horizontalController: _scrollState.getHorizontalController(
                    railData.id,
                  ),
                  isFirstRail: index == 0,
                );
              }, childCount: _introRails.length),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 48)),
          ],
        ),
      ],
    );
  }
}

// --- Mobile Intro Page Implementation ---

class MobileIntroPage extends StatefulWidget {
  const MobileIntroPage({super.key});

  @override
  State<MobileIntroPage> createState() => _MobileIntroPageState();
}

class _MobileIntroPageState extends State<MobileIntroPage> {
  late final ScrollController _verticalScrollController;
  late final PageScrollUiModel _scrollState;
  final List<ContentRailData> _introRails = mockData.take(3).toList();

  @override
  void initState() {
    super.initState();
    _scrollState = context.read<PageScrollUiModel>();
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
