// A fixed height for each rail is crucial for calculating the layout.
const double kRailPadding = 12.0;
const double kTitleHeight = 24.0;
const double kRailTitlePadding = 8.0;
const double kRailHeight = 140.0;
const double kFullRailHeight = 196.0;
const double kHalfRailHeight =
    kRailPadding + kTitleHeight + kRailTitlePadding + kRailHeight / 2.0;
const Duration kAnimationDuration = Duration(milliseconds: 160);
// A fixed width for each tile, used for horizontal scroll calculations.
const double kTileWidth = 248.0; // Aspect ratio 16/9 * height 140
const double kTileSpacing = 16.0;
