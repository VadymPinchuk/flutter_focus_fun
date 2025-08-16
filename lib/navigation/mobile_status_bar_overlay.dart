import 'dart:ui';

import 'package:flutter/material.dart';

class MobileStatusBarOverlay extends StatelessWidget {
  const MobileStatusBarOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.paddingOf(context).top,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.blueGrey[900]!.withValues(alpha: 0.75),
          ),
        ),
      ),
    );
  }
}
