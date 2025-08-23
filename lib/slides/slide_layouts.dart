import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/slide_data.dart';
import 'package:flutter_focus_fun_tv_demo/slides/template_slide.dart';
import 'package:flutter_focus_fun_tv_demo/slides/widgets/bullet_list_widget.dart';
import 'package:flutter_focus_fun_tv_demo/slides/widgets/code_sample_widget.dart';
import 'package:flutter_focus_fun_tv_demo/slides/widgets/image_widget.dart';
import 'package:flutter_focus_fun_tv_demo/slides/widgets/plain_text_widget.dart';

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
            child: CodeSamplesWidget(codeSnippets: data.codeSamples ?? []),
          ),
        ],
      ),
    );
  }
}

class SingleTextLayout extends StatelessWidget {
  final SlideData data;

  const SingleTextLayout({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // This layout now chooses between a bullet list or plain text.
    final Widget textContent =
        data.plainText != null
            ? PlainTextWidget(text: data.plainText!)
            : BulletListWidget(bullets: data.leftBullets ?? []);

    return TemplateSlide(
      title: data.title,
      subtitle: data.subtitle,
      child: textContent,
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
          Expanded(
            child: CodeSamplesWidget(codeSnippets: data.codeSamples ?? []),
          ),
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
          Expanded(
            child: CodeSamplesWidget(codeSnippets: data.codeSamples ?? []),
          ),
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
      child: CodeSamplesWidget(codeSnippets: data.codeSamples ?? []),
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
          Expanded(
            child: CodeSamplesWidget(codeSnippets: data.codeSamples ?? []),
          ),
          const SizedBox(width: 32),
          Expanded(
            child: CodeSamplesWidget(codeSnippets: data.codeSamples ?? []),
          ),
        ],
      ),
    );
  }
}
