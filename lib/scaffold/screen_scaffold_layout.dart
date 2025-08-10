import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/background_image.dart';

enum ScreenSlot { header, body, footer }

class BodyBuilder extends StatelessWidget {
  final Widget body;

  const BodyBuilder({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final _BodyBoxConstraints bodyConstraints =
            constraints as _BodyBoxConstraints;
        final screenData = MediaQuery.of(context);
        final padding = screenData.padding;

        final top = max(padding.top, bodyConstraints.headerHeight);
        final bottom = max(padding.bottom, bodyConstraints.footerHeight);

        return MediaQuery(
          data: screenData.copyWith(
            padding: padding.copyWith(top: top, bottom: bottom),
          ),
          child: Material(
            child: Stack(
              fit: StackFit.expand,
              children: [const BackgroundImage(), body],
            ),
          ),
        );
      },
    );
  }
}

class ScreenScaffoldLayout extends MultiChildLayoutDelegate {
  ScreenScaffoldLayout();

  @override
  void performLayout(Size size) {
    final BoxConstraints looseConstraints = BoxConstraints.loose(size);
    final BoxConstraints fullWidthConstraints = looseConstraints.tighten(
      width: size.width,
    );

    double headerHeight = 0;
    if (hasChild(ScreenSlot.header)) {
      headerHeight =
          layoutChild(ScreenSlot.header, fullWidthConstraints).height;
      positionChild(ScreenSlot.header, Offset.zero);
    }

    double footerHeight = 0;
    if (hasChild(ScreenSlot.footer)) {
      footerHeight =
          layoutChild(ScreenSlot.footer, fullWidthConstraints).height;
      positionChild(ScreenSlot.footer, Offset(0, size.height - footerHeight));
    }

    final BoxConstraints bodyConstraints = _BodyBoxConstraints(
      maxWidth: looseConstraints.maxWidth,
      maxHeight: looseConstraints.maxHeight,
      headerHeight: headerHeight,
      footerHeight: footerHeight,
    );

    layoutChild(ScreenSlot.body, bodyConstraints);
    positionChild(ScreenSlot.body, Offset.zero);
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => true;
}

/// Custom constraints class to pass header and footer height down, to the body builder
class _BodyBoxConstraints extends BoxConstraints {
  final double headerHeight;
  final double footerHeight;

  const _BodyBoxConstraints({
    super.maxWidth,
    super.maxHeight,
    required this.headerHeight,
    required this.footerHeight,
  }) : assert(headerHeight >= 0, footerHeight >= 0);

  @override
  bool operator ==(covariant _BodyBoxConstraints other) {
    if (super != other) {
      return false;
    }
    return other.hashCode == hashCode;
  }

  @override
  int get hashCode => Object.hash(super.hashCode, headerHeight, footerHeight);
}
