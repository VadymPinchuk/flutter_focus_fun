import 'package:flutter/material.dart';

/// A widget that renders a list of strings as a formatted bullet list.
class BulletListWidget extends StatelessWidget {
  final List<String> bullets;

  const BulletListWidget({super.key, required this.bullets});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          bullets
              .map(
                (text) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '• ',
                        style: TextStyle(fontSize: 22, color: Colors.white70),
                      ),
                      Expanded(
                        child: Text(text, style: const TextStyle(fontSize: 22)),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
    );
  }
}
