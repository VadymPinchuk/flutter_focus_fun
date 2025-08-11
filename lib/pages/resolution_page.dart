import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/mock_rail_data.dart'
    show ContentRailData, mockData;
import 'package:flutter_focus_fun_tv_demo/grid_traversal_policy.dart';
import 'package:flutter_focus_fun_tv_demo/model/tv_page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/utils/ui_experience.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/dynamic_background.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/mobile_rail.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/tv_rail.dart';
import 'package:provider/provider.dart';

class ResolutionPage extends StatelessWidget {
  const ResolutionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return switch (context.read<UiExperience>()) {
      UiExperience.mobile => const MobileResolutionPage(),
      UiExperience.tv => const TvResolutionPage(),
    };
  }
}

class TvResolutionPage extends StatefulWidget {
  const TvResolutionPage({super.key});

  @override
  State<TvResolutionPage> createState() => _TvResolutionPageState();
}

class _TvResolutionPageState extends State<TvResolutionPage> {
  late final ScrollController _verticalScrollController;
  late final TvPageUiModel _scrollState;
  final List<ContentRailData> _resolutionRails = mockData.skip(3).toList();

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

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (_resolutionRails.isNotEmpty &&
    //       _resolutionRails.first.items.isNotEmpty) {
    //     context.read<TvUiModel>().focusedItem.value =
    //         _resolutionRails.first.items.first;
    //   }
    // });
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
        FocusTraversalGroup(
          policy: GridTraversalPolicy(),
          child: CustomScrollView(
            controller: _verticalScrollController,
            slivers: [
              const SliverPadding(padding: EdgeInsets.only(top: 600)),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final railData = _resolutionRails[index];
                  return TvRail(
                    data: railData,
                    railIndex: index,
                    horizontalController: _scrollState.getHorizontalController(
                      railData.id,
                    ),
                    isFirstRail: index == 0,
                  );
                }, childCount: _resolutionRails.length),
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 48)),
            ],
          ),
        ),
      ],
    );
  }
}

class MobileResolutionPage extends StatefulWidget {
  const MobileResolutionPage({super.key});

  @override
  State<MobileResolutionPage> createState() => _MobileResolutionPageState();
}

class _MobileResolutionPageState extends State<MobileResolutionPage> {
  late final ScrollController _verticalScrollController;
  late final TvPageUiModel _scrollState;
  final List<ContentRailData> _resolutionRails = mockData.skip(3).toList();

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
        ..._resolutionRails.map((railData) {
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
