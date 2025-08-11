import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/mock_rail_data.dart'
    show ContentRailData;
import 'package:flutter_focus_fun_tv_demo/model/tv_page_ui_model.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/dynamic_background.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/rail_wrapper.dart';
import 'package:flutter_focus_fun_tv_demo/widgets/tv_rail.dart';
import 'package:provider/provider.dart';

class BodyWidget extends StatefulWidget {
  final List<ContentRailData> rails;

  const BodyWidget({super.key, required this.rails});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  late final ScrollController _verticalScrollController;
  late final TvPageUiModel _scrollState;

  // State to track the currently focused rail.
  int _focusedRailIndex = 0;

  // A fixed height for each rail is crucial for calculating the layout.
  static const double _kRailHeight = 192.0;

  @override
  void initState() {
    super.initState();
    _scrollState = context.read<TvPageUiModel>();
    _verticalScrollController = ScrollController();

    // After the first frame is built, calculate and jump to the initial scroll position.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final screenHeight = MediaQuery.sizeOf(context).height;
        final initialOffset = screenHeight - (1.5 * _kRailHeight);
        _verticalScrollController.jumpTo(initialOffset);
        _scrollState.setVerticalOffset(initialOffset);
      }
    });

    _verticalScrollController.addListener(() {
      _scrollState.setVerticalOffset(_verticalScrollController.offset);
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
      _scrollToRail(railIndex);
      setState(() {
        _focusedRailIndex = railIndex;
      });
    }
  }

  /// Scrolls the vertical list by one rail height up or down.
  void _scrollToRail(int newRailIndex) {
    final direction = newRailIndex > _focusedRailIndex ? 1 : -1;
    final currentOffset = _verticalScrollController.offset;
    final newOffset = currentOffset + (direction * _kRailHeight);

    final maxScroll = _verticalScrollController.position.maxScrollExtent;
    final clampedOffset = newOffset.clamp(0.0, maxScroll);

    _verticalScrollController.animateTo(
      clampedOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final topPadding = screenHeight - (1.5 * _kRailHeight);
    final bottomPadding = _kRailHeight / 2;

    return Stack(
      children: [
        const DynamicBackground(),
        CustomScrollView(
          controller: _verticalScrollController,
          slivers: [
            SliverPadding(padding: EdgeInsets.only(top: topPadding)),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final railData = widget.rails[index];
                return RailWrapper(
                  railIndex: index,
                  child: TvRail(
                    data: railData,
                    railIndex: index,
                    horizontalController: _scrollState.getHorizontalController(
                      railData.id,
                    ),
                    isFirstRail: index == 0,
                  ),
                );
              }, childCount: widget.rails.length),
            ),
            SliverPadding(padding: EdgeInsets.only(bottom: bottomPadding)),
          ],
        ),
      ],
    );
  }
}
