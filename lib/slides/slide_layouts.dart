import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_focus_fun_tv_demo/data/slide_data.dart';
import 'package:flutter_focus_fun_tv_demo/slides/template_slide.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

// --- Reusable Slide Components ---

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

/// A widget that renders a string of code with syntax highlighting.
class CodeSampleWidget extends StatelessWidget {
  final String code;

  const CodeSampleWidget({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme(
          linesCountColor: const Color.fromARGB(179, 255, 255, 255),
          backgroundColor: const Color(0xFF1E1E1E),
          baseStyle: const TextStyle(color: Color(0xFFD4D4D4), fontSize: 20),
          numberStyle: const TextStyle(color: Color(0xFFB5CEA8), fontSize: 20),
          commentStyle: const TextStyle(color: Color(0xFF6A9955), fontSize: 20),
          keywordStyle: const TextStyle(color: Color(0xFF569CD6), fontSize: 20),
          stringStyle: const TextStyle(color: Color(0xFFD69D85), fontSize: 20),
          punctuationStyle: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 20,
          ),
          classStyle: const TextStyle(color: Color(0xFF4EC9B0), fontSize: 20),
          constantStyle: const TextStyle(
            color: Color(0xFF9CDCFE),
            fontSize: 20,
          ),
          zoomIconColor: const Color(0xFFF8F6EB),
        ),
        withLinesCount: true,
        expanded: false,
      ),
    );
  }
}

/// A widget that renders an image from an asset path.
class ImageWidget extends StatelessWidget {
  final String imagePath;

  const ImageWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
        errorBuilder: (c, e, s) => const Placeholder(),
      ),
    );
  }
}

// --- Specific Slide Layout Implementations ---

/// A slide layout that displays bullet points on the left and a code sample on the right.
class LeftTextRightCodeLayout extends StatelessWidget {
  final SlideData data;

  const LeftTextRightCodeLayout({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TemplateSlide(
      title: data.title,
      subtitle: data.subtitle,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column
          Expanded(
            flex: 2,
            child: BulletListWidget(bullets: data.leftBullets ?? []),
          ),
          const SizedBox(width: 32),
          // Right Column
          Expanded(
            flex: 3,
            child: CodeSampleWidget(code: data.codeSample ?? ''),
          ),
        ],
      ),
    );
  }
}

// --- Placeholder Layouts for Other Slide Types ---

class SingleTextLayout extends StatelessWidget {
  final SlideData data;

  const SingleTextLayout({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TemplateSlide(
      title: data.title,
      subtitle: data.subtitle,
      child: BulletListWidget(bullets: data.leftBullets ?? []),
    );
  }
}

class DoubleTextLayout extends StatelessWidget {
  final SlideData data;

  const DoubleTextLayout({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TemplateSlide(
      title: data.title,
      subtitle: data.subtitle,
      child: Row(
        children: [
          Expanded(child: BulletListWidget(bullets: data.leftBullets ?? [])),
          const SizedBox(width: 32),
          Expanded(child: BulletListWidget(bullets: data.rightBullets ?? [])),
        ],
      ),
    );
  }
}

class LeftTextRightImageLayout extends StatelessWidget {
  final SlideData data;

  const LeftTextRightImageLayout({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TemplateSlide(
      title: data.title,
      subtitle: data.subtitle,
      child: Row(
        children: [
          Expanded(child: BulletListWidget(bullets: data.leftBullets ?? [])),
          const SizedBox(width: 32),
          Expanded(child: ImageWidget(imagePath: data.rightImagePath ?? '')),
        ],
      ),
    );
  }
}

class LeftImageRightTextLayout extends StatelessWidget {
  final SlideData data;

  const LeftImageRightTextLayout({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TemplateSlide(
      title: data.title,
      subtitle: data.subtitle,
      child: Row(
        children: [
          Expanded(child: ImageWidget(imagePath: data.leftImagePath ?? '')),
          const SizedBox(width: 32),
          Expanded(child: BulletListWidget(bullets: data.rightBullets ?? [])),
        ],
      ),
    );
  }
}

class LeftImageRightCodeLayout extends StatelessWidget {
  final SlideData data;

  const LeftImageRightCodeLayout({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TemplateSlide(
      title: data.title,
      subtitle: data.subtitle,
      child: Row(
        children: [
          Expanded(child: ImageWidget(imagePath: data.leftImagePath ?? '')),
          const SizedBox(width: 32),
          Expanded(child: CodeSampleWidget(code: data.codeSample ?? '')),
        ],
      ),
    );
  }
}

class LeftCodeRightImageLayout extends StatelessWidget {
  final SlideData data;

  const LeftCodeRightImageLayout({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TemplateSlide(
      title: data.title,
      subtitle: data.subtitle,
      child: Row(
        children: [
          Expanded(child: CodeSampleWidget(code: data.codeSample ?? '')),
          const SizedBox(width: 32),
          Expanded(child: ImageWidget(imagePath: data.rightImagePath ?? '')),
        ],
      ),
    );
  }
}

class SingleCodeLayout extends StatelessWidget {
  final SlideData data;

  const SingleCodeLayout({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TemplateSlide(
      title: data.title,
      subtitle: data.subtitle,
      child: CodeSampleWidget(code: data.codeSample ?? ''),
    );
  }
}

class DoubleCodeLayout extends StatelessWidget {
  final SlideData data;

  const DoubleCodeLayout({super.key, required this.data});

  // This assumes you might have two code samples, you'd need to add a `codeSample2` field to your data model.
  @override
  Widget build(BuildContext context) {
    return TemplateSlide(
      title: data.title,
      subtitle: data.subtitle,
      child: Row(
        children: [
          Expanded(child: CodeSampleWidget(code: data.codeSample ?? '')),
          const SizedBox(width: 32),
          Expanded(child: CodeSampleWidget(code: data.codeSample ?? '')),
        ],
      ),
    );
  }
}
