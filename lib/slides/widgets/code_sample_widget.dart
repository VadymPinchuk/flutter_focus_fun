import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
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
        spacing: 32.0,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            snippets
                .map(
                  (code) => ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SyntaxView(
                      code: code,
                      syntax: Syntax.DART,
                      syntaxTheme: context.syntaxTheme,
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

extension on BuildContext {
  SyntaxTheme get syntaxTheme {
    final textSize = 24.0 * textScale;
    return SyntaxTheme(
      linesCountColor: const Color.fromARGB(179, 255, 255, 255),
      backgroundColor: const Color(0xFF1E1E1E),
      baseStyle: TextStyle(color: Color(0xFFD4D4D4), fontSize: textSize),
      numberStyle: TextStyle(color: Color(0xFFB5CEA8), fontSize: textSize),
      commentStyle: TextStyle(color: Color(0xFF6A9955), fontSize: textSize),
      keywordStyle: TextStyle(color: Color(0xFF569CD6), fontSize: textSize),
      stringStyle: TextStyle(color: Color(0xFFD69D85), fontSize: textSize),
      punctuationStyle: TextStyle(color: Color(0xFFFFFFFF), fontSize: textSize),
      classStyle: TextStyle(color: Color(0xFF4EC9B0), fontSize: textSize),
      constantStyle: TextStyle(color: Color(0xFF9CDCFE), fontSize: textSize),
      zoomIconColor: Color(0xFFF8F6EB),
    );
  }
}
