import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/utils/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/utils/scope_functions.dart';
import 'package:flutter_focus_fun_tv_demo/utils/ui_experience.dart'
    show UiExperience;
import 'package:flutter_focus_fun_tv_demo/widgets/background_image.dart';

enum PageScaffoldSlot { body, header, statusBar }

class PageScaffold extends StatelessWidget {
  final Widget? header;
  final Widget body;

  const PageScaffold({super.key, this.header, required this.body});

  @override
  Widget build(BuildContext context) {
    return switch (context.uiExperience) {
      UiExperience.tv => _TvLayout(header: header, body: body),
      UiExperience.mobile => _MobileLayout(header: header, body: body),
    };
  }
}

class _TvLayout extends StatelessWidget {
  final Widget? header;
  final Widget body;

  const _TvLayout({required this.header, required this.body});

  @override
  Widget build(BuildContext context) => ScrollNotificationObserver(
    child: _BodyHeaderLayout(header: header, body: body),
  );
}

class _MobileLayout extends StatelessWidget {
  final Widget? header;
  final Widget body;
  final List<Widget> children;

  const _MobileLayout({
    required this.header,
    required this.body,
    this.children = const <Widget>[],
  });

  @override
  Widget build(BuildContext context) => ScrollNotificationObserver(
    child: _BodyHeaderLayout(header: header, body: body, children: children),
  );
}

class _BodyHeaderLayout extends StatelessWidget {
  final Widget body;
  final Widget? header;
  final List<Widget> children;

  const _BodyHeaderLayout({
    required this.body,
    this.header,
    this.children = const <Widget>[],
  });

  @override
  Widget build(BuildContext context) {
    final coreWidgets = <Widget>[
      LayoutId(id: PageScaffoldSlot.body, child: _BodyBuilder(body: body)),
    ];

    header?.also(
      (it) => coreWidgets.add(LayoutId(id: PageScaffoldSlot.header, child: it)),
    );

    return CustomMultiChildLayout(
      delegate: _PageScaffoldLayout(minInsets: MediaQuery.paddingOf(context)),
      children: [...coreWidgets, ...children],
    );
  }
}

class _BodyBuilder extends StatelessWidget {
  final Widget body;

  const _BodyBuilder({required this.body});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (BuildContext _, BoxConstraints constraints) {
      final _BodyBoxConstraints bodyConstraints =
          constraints as _BodyBoxConstraints;
      final MediaQueryData metrics = MediaQuery.of(context);
      final double top = max(metrics.padding.top, bodyConstraints.headerHeight);

      return MediaQuery(
        data: metrics.copyWith(padding: metrics.padding.copyWith(top: top)),
        child: Material(
          child: Stack(
            fit: StackFit.expand,
            children: [BackgroundImage(), body],
          ),
        ),
      );
    },
  );
}

class _PageScaffoldLayout extends MultiChildLayoutDelegate {
  final EdgeInsets minInsets;

  _PageScaffoldLayout({required this.minInsets});

  double _layoutHeader(BoxConstraints fullWidthConstraints) {
    if (hasChild(PageScaffoldSlot.header)) {
      final headerHeight =
          layoutChild(PageScaffoldSlot.header, fullWidthConstraints).height;
      positionChild(PageScaffoldSlot.header, Offset.zero);
      return headerHeight;
    }

    return 0;
  }

  @override
  void performLayout(Size size) {
    final BoxConstraints looseConstraints = BoxConstraints.loose(size);
    final BoxConstraints fullWidthConstraints = looseConstraints.tighten(
      width: size.width,
    );

    final headerHeight = _layoutHeader(fullWidthConstraints);

    final BoxConstraints bodyConstraints = _BodyBoxConstraints(
      maxWidth: looseConstraints.maxWidth,
      maxHeight: looseConstraints.maxHeight,
      headerHeight: headerHeight,
    );
    layoutChild(PageScaffoldSlot.body, bodyConstraints);
    positionChild(PageScaffoldSlot.body, Offset.zero);
    if (hasChild(PageScaffoldSlot.statusBar)) {
      layoutChild(
        PageScaffoldSlot.statusBar,
        fullWidthConstraints.tighten(height: minInsets.top),
      );
      positionChild(PageScaffoldSlot.statusBar, Offset.zero);
    }
  }

  @override
  bool shouldRelayout(covariant _PageScaffoldLayout oldDelegate) => false;
}

/// Custom constraints class to pass header and footer height down, to the body builder
class _BodyBoxConstraints extends BoxConstraints {
  final double headerHeight;

  const _BodyBoxConstraints({
    super.maxWidth,
    super.maxHeight,
    required this.headerHeight,
  }) : assert(headerHeight >= 0);

  // RenderObject.layout() will only short-circuit its call to its performLayout
  // method if the new layout constraints are not == to the current constraints.
  // If the height of the header widget has changed, even though the constraints'
  // min and max values have not, we still want performLayout to happen.
  @override
  bool operator ==(covariant _BodyBoxConstraints other) {
    if (super != other) {
      return false;
    }
    return other.headerHeight == headerHeight;
  }

  @override
  int get hashCode => Object.hash(super.hashCode, headerHeight);
}
