import 'package:flutter/painting.dart';
import 'package:flutter_focus_fun_tv_demo/responsive/tile_measure_helper.dart';
import 'package:flutter_focus_fun_tv_demo/utils/user_experience.dart';

const double kLandscapeAspectRatio = 16 / 9;

class RailData {
  late final double railFullHeight;
  late final double railHalfHeight;
  final double railHorizontalPadding;
  final double railVerticalPadding;
  final double railTitleSpacing;
  final double titleHeight;
  final double tilesSpacing;
  final double tilesInRow;
  final Size tileSize;

  factory RailData.forExperience(
    UserExperience experience,
    double screenWidth,
    double tilesInRow,
    double textScale,
  ) {
    return switch (experience) {
      UserExperience.mobile => RailData._mobile(
        screenWidth,
        tilesInRow,
        textScale,
      ),
      UserExperience.tv => RailData._tv(screenWidth, tilesInRow, textScale),
    };
  }

  RailData._(
    double screenWidth,
    double tilesCount,
    double textScale, {
    required this.railHorizontalPadding,
    required this.tilesSpacing,
    required this.railTitleSpacing,
  }) : titleHeight = 24.0 * textScale,
       tilesInRow = tilesCount,
       tileSize = TileMeasureHelper.getTileSize(
         TileMeasureHelper.calculateTileWidth(
           itemsPerRow: tilesCount,
           screenWidth: screenWidth,
           tileSpacing: tilesSpacing,
           horizontalMargin: railHorizontalPadding,
         ),
         kLandscapeAspectRatio,
       ),
       railVerticalPadding = 12.0 {
    railFullHeight =
        titleHeight +
        railTitleSpacing +
        tileSize.height +
        railVerticalPadding * 2;
    railHalfHeight =
        titleHeight +
        railTitleSpacing +
        tileSize.height / 2 +
        railVerticalPadding;
  }

  factory RailData._mobile(
    double screenWidth,
    double tilesInRow,
    double textScale,
  ) => RailData._(
    screenWidth,
    tilesInRow,
    textScale,
    railHorizontalPadding: 24.0,
    tilesSpacing: 16.0,
    railTitleSpacing: 8.0,
  );

  factory RailData._tv(
    double screenWidth,
    double tilesInRow,
    double textScale,
  ) => RailData._(
    screenWidth,
    tilesInRow,
    textScale,
    railHorizontalPadding: 96.0,
    tilesSpacing: 24.0,
    railTitleSpacing: 12.0,
  );
}
