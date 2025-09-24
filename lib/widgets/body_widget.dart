import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/data/content_rail_data.dart';
import 'package:flutter_focus_fun_tv_demo/model/page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/scroll/tv_rail_scroll_controller.dart';
import 'package:flutter_focus_fun_tv_demo/utils/scope_functions.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/dynamic_content.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/rail_wrapper.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/tv_rail.dart';

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
    final newOffset =
        currentOffset + (direction * context.railData.railFullHeight);

    final maxScroll = _verticalScrollController.position.maxScrollExtent;
    final clampedOffset = newOffset.clamp(0.0, maxScroll);

    _verticalScrollController.animateTo(
      clampedOffset,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return ValueListenableBuilder(
      valueListenable: context.settingsModel.useTvPageLayout,
      builder: (ctx, useTvPageLayout, _) {
        return Stack(
          children: [
            useTvPageLayout
                ? ValueListenableBuilder(
                  valueListenable: context.pageUiModel.focusedItem,
                  builder:
                      (_, focusedItem, _) => _ImageMask(
                        child: DynamicContent(focusedItem: focusedItem),
                      ),
                )
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
                            ? screenHeight -
                                (context.railData.railFullHeight +
                                    context.railData.railQuarterHeight)
                            : 0.0,
                  ),
                ),

                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final railContent = widget.rails[index];
                    return TvRail(
                      data: railContent,
                      railIndex: index,
                      railScrollController: TvRailScrollController(
                        scrollController: _pageModel.getHorizontalController(
                          railContent.id,
                        ),
                        tileWidth: context.railData.tileSize.width,
                        tileSpacing: context.railData.tilesSpacing,
                        railPadding: context.railData.railHorizontalPadding,
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
                SliverToBoxAdapter(
                  child: SizedBox(height: context.railData.tileSize.height),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _ImageMask extends StatelessWidget {
  const _ImageMask({required this.child});

  final Widget child;

  LinearGradient get _bottomGradient => LinearGradient(
    colors: [
      Colors.black,
      Colors.black,
      Colors.black.withValues(alpha: 0.8),
      Colors.black.withValues(alpha: 0.3),
      Colors.black.withValues(alpha: 0.0),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: const [0.0, 0.1, 0.6, 0.7, 1.0],
  );

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: _bottomGradient.createShader,
      blendMode: BlendMode.dstIn,
      child: child,
    );
  }
}
