import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/scaffold/screen_scaffold_layout.dart';
import 'package:flutter_focus_fun_tv_demo/utils/scope_functions.dart';

class ScreenScaffold extends StatelessWidget {
  final Widget? header; // TopNavBar on web
  final Widget body; // PageScaffold or Page as is
  final Widget? footer; // BottomNavBar - mobile

  const ScreenScaffold({
    super.key,
    this.header,
    required this.body,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];

    children.add(LayoutId(id: ScreenSlot.body, child: BodyBuilder(body: body)));

    header?.let((it) {
      children.add(LayoutId(id: ScreenSlot.header, child: it));
    });
    footer?.let((it) {
      children.add(LayoutId(id: ScreenSlot.footer, child: it));
    });
    return Material(
      child: CustomMultiChildLayout(
        delegate: ScreenScaffoldLayout(),
        children: children,
      ),
    );
  }
}
