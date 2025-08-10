import 'package:flutter/material.dart';

/// Background used all over the application
class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: double.infinity,
      width: double.infinity,
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.centerEnd,
          colors: [
            Colors.grey[900]!,
            Colors.blueGrey[900]!,
            Colors.blueGrey[800]!,
            Colors.grey[900]!,
          ],
        ),
      ),
    );
  }
}
