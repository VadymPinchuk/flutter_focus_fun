import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        spacing: 8.0,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'No touch. No gestures. Can you still build a Great UX?',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          const Text(
            'by',
            style: TextStyle(color: Colors.white70, fontSize: 16.0),
          ),
          Image.asset(
            'assets/images/hat.png',
            height: 32,
            errorBuilder:
                (c, e, s) => const Icon(Icons.person, color: Colors.white70),
          ),
          const Text(
            'for',
            style: TextStyle(color: Colors.white70, fontSize: 16.0),
          ),
          FlutterLogo(
            size: 32,
            textColor: Colors.white,
            style: FlutterLogoStyle.markOnly,
            curve: Curves.easeInOut,
          ),
          // Image.asset(
          //   'assets/images/conference.png',
          //   height: 32,
          //   errorBuilder:
          //       (c, e, s) => const Icon(Icons.groups, color: Colors.white70),
          // ),
        ],
      ),
    );
  }
}
