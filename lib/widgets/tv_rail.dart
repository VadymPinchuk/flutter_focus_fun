import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/data/mock_rail_data.dart'
    show ContentRailData;
import 'package:flutter_focus_fun_tv_demo/widgets/tv_tile.dart' show TvTile;
import 'package:provider/provider.dart';

import '../model/tv_ui_model.dart';

class NoArrowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

class TvRail extends StatelessWidget {
  final ContentRailData data;
  final int railIndex;
  final ScrollController horizontalController;
  final bool isFirstRail;

  const TvRail({
    super.key,
    required this.data,
    required this.railIndex,
    required this.horizontalController,
    this.isFirstRail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: ValueListenableBuilder<TvNavBarLocation>(
        valueListenable: context.read<TvUiModel>().navBarLocation,
        builder: (_, location, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: location == TvNavBarLocation.left ? 116.0 : 48.0,
                  right: 48.0,
                ),
                child: Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 140,
                child: ScrollConfiguration(
                  behavior: NoArrowScrollBehavior(),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    controller: horizontalController,
                    clipBehavior: Clip.none,
                    padding: EdgeInsets.only(
                      left: location == TvNavBarLocation.left ? 116.0 : 48.0,
                      right: 48.0,
                    ),
                    itemCount: data.items.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 16.0),
                    itemBuilder: (_, index) {
                      final item = data.items[index];
                      return TvTile(
                        item: item,
                        autofocus: isFirstRail && index == 0,
                        onFocusChange: (item, hasFocus) {
                          if (hasFocus) {
                            context.tvPageUiModel.focusedRailIndex.value =
                                railIndex;
                            context.tvPageUiModel.focusedItem.value = item;
                            Scrollable.ensureVisible(
                              context,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              alignment: 0.5,
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
