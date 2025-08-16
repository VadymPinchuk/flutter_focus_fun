import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/constants.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/data/mock_rail_data.dart';
import 'package:flutter_focus_fun_tv_demo/model/page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/utils/scope_functions.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/dynamic_background.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/rail_wrapper.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/tv_rail.dart';

/// A custom scroll controller that handles precise scrolling for a horizontal TV rail.
/// It accounts for list padding to ensure focused items are correctly positioned.
class TvRailScrollController {
  final ScrollController scrollController;
  final double tileWidth;
  final double tileSpacing;
  final double railPadding;

  TvRailScrollController({
    required this.scrollController,
    required this.tileWidth,
    required this.tileSpacing,
    required this.railPadding,
  });

  /// Scrolls the list to bring the item at the given index into view.
  void scrollToIndex(int index) {
    // Calculate the target offset to center the tile, accounting for the left padding.
    final targetOffset = (index * (tileWidth + tileSpacing));

    scrollController.animateTo(
      targetOffset.clamp(0.0, scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
    );
  }
}

class BodyWidget extends StatefulWidget {
  final List<ContentRailData> rails;

  const BodyWidget({super.key, required this.rails});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  late final ScrollController _verticalScrollController;
  late final PageUiModel _pageModel;

  // State to track the currently focused rail.
  int _focusedRailIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageModel = context.pageUiModel;
    _verticalScrollController = ScrollController();

    // // After the first frame is built, calculate and jump to the initial scroll position.
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (mounted) {
    //     // final screenHeight = MediaQuery.sizeOf(context).height;
    //     // final initialOffset = screenHeight - (1.5 * _kRailHeight);
    //     // _verticalScrollController.jumpTo(initialOffset);
    //     // _pageModel.setVerticalOffset(initialOffset);
    //   }
    // });
    //
    _verticalScrollController.addListener(() {
      _pageModel.setVerticalOffset(_verticalScrollController.offset);
    });
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    super.dispose();
  }

  /// Callback triggered when a tile in a rail receives focus.
  void _onFocusChange(int railIndex) {
    // If the focus has moved to a new rail, trigger a scroll.
    if (_focusedRailIndex != railIndex) {
      context.pageUiModel.focusedRailIndex.value = railIndex;
      _scrollToRail(railIndex);
      setState(() {
        _focusedRailIndex = railIndex;
      });
    }
  }

  /// Scrolls the vertical list by one rail height up or down.
  void _scrollToRail(int newRailIndex) {
    if (_focusedRailIndex == newRailIndex) return;
    final direction = newRailIndex > _focusedRailIndex ? 1 : -1;
    final currentOffset = _verticalScrollController.offset;
    final newOffset = currentOffset + (direction * kRailHeight);

    final maxScroll = _verticalScrollController.position.maxScrollExtent;
    final clampedOffset = newOffset.clamp(0.0, maxScroll);

    _verticalScrollController.animateTo(
      clampedOffset,
      duration: kAnimationDuration,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final isHorizontalNavBar =
        context.settingsModel.uiExperience.value.isMobile;
    final railPadding = isHorizontalNavBar ? 48.0 : 80.0;

    return ValueListenableBuilder(
      valueListenable: context.settingsModel.useTvPageLayout,
      builder:
          (_, useTvPageLayout, __) => Stack(
            children: [
              useTvPageLayout
                  ? const DynamicBackground()
                  : const SizedBox.shrink(),
              CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _verticalScrollController,
                slivers: [
                  // shift rail to bottom part of the screen
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height:
                          useTvPageLayout
                              ? screenHeight - (1.5 * kRailHeight)
                              : 0.0,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final railData = widget.rails[index];
                      return TvRail(
                        data: railData,
                        railIndex: index,
                        railScrollController: TvRailScrollController(
                          scrollController: _pageModel.getHorizontalController(
                            railData.id,
                          ),
                          tileWidth: kTileWidth,
                          tileSpacing: kTileSpacing,
                          railPadding: railPadding,
                        ),
                        onFocusChange: (_) {
                          if (useTvPageLayout) _onFocusChange(index);
                        },
                      ).let(
                        (rail) =>
                            useTvPageLayout
                                ? RailWrapper(railIndex: index, child: rail)
                                : rail,
                      );
                    }, childCount: widget.rails.length),
                  ),
                  // save some space at the bottom to make rail scroll nice
                  SliverToBoxAdapter(child: SizedBox(height: kRailHeight / 2)),
                ],
              ),
            ],
          ),
    );
  }
}
