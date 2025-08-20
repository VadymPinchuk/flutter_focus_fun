import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/utils/scope_functions.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

/// A widget that renders a string of code with syntax highlighting.
class CodeSamplesWidget extends StatelessWidget {
  final List<String>? codeSnippets;

  const CodeSamplesWidget({super.key, required this.codeSnippets});

  @override
  Widget build(BuildContext context) {
    return codeSnippets.letOrElse(
      (snippets) => Column(
        spacing: 16.0,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            snippets
                .map(
                  (code) => ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SyntaxView(
                      code: code,
                      syntax: Syntax.DART,
                      syntaxTheme: _syntaxTheme,
                      withLinesCount: false,
                      expanded: false,
                      selectable: false,
                      withZoom: false,
                    ),
                  ),
                )
                .toList(),
      ),
      orElse: () => const SizedBox.shrink(),
    );
  }
}

final _syntaxTheme = SyntaxTheme(
  linesCountColor: const Color.fromARGB(179, 255, 255, 255),
  backgroundColor: const Color(0xFF1E1E1E),
  baseStyle: const TextStyle(color: Color(0xFFD4D4D4), fontSize: 20),
  numberStyle: const TextStyle(color: Color(0xFFB5CEA8), fontSize: 20),
  commentStyle: const TextStyle(color: Color(0xFF6A9955), fontSize: 20),
  keywordStyle: const TextStyle(color: Color(0xFF569CD6), fontSize: 20),
  stringStyle: const TextStyle(color: Color(0xFFD69D85), fontSize: 20),
  punctuationStyle: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 20),
  classStyle: const TextStyle(color: Color(0xFF4EC9B0), fontSize: 20),
  constantStyle: const TextStyle(color: Color(0xFF9CDCFE), fontSize: 20),
  zoomIconColor: const Color(0xFFF8F6EB),
);
