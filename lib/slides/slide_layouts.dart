import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data/slide_data.dart';
import 'package:flutter_focus_fun_tv_demo/slides/template_slide.dart';
import 'package:flutter_focus_fun_tv_demo/slides/widgets/bullet_list_widget.dart';
import 'package:flutter_focus_fun_tv_demo/slides/widgets/code_sample_widget.dart';

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
        spacing: 32.0,
        children: [
          Expanded(child: BulletListWidget(bullets: data.leftBullets ?? [])),
          Expanded(child: CodeSamplesWidget(codeSnippets: data.codeSamples)),
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
          Expanded(child: CodeSamplesWidget(codeSnippets: data.codeSamples)),
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
          Expanded(child: CodeSamplesWidget(codeSnippets: data.codeSamples)),
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
      child: CodeSamplesWidget(codeSnippets: data.codeSamples),
    );
  }
}
