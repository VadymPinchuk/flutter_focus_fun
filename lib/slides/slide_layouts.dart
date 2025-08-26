import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/data_models/slide_data.dart';
import 'package:flutter_focus_fun_tv_demo/slides/template_slide.dart';
import 'package:flutter_focus_fun_tv_demo/slides/widgets/body_text.dart';
import 'package:flutter_focus_fun_tv_demo/slides/widgets/body_text_widget.dart';
import 'package:flutter_focus_fun_tv_demo/slides/widgets/code_snippets_widget.dart';
import 'package:flutter_focus_fun_tv_demo/slides/widgets/image_widget.dart';

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox(width: 64);
}

/// A slide layout that displays bullet points on the left and a code sample on the right.
class LeftTextRightCodeLayout extends StatelessWidget {
  final SlideData data;

  const LeftTextRightCodeLayout({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TemplateSlide(
      title: data.title,
      subtitle: data.subtitle,
      children: [
        Expanded(child: BodyTextWidget(bullets: data.leftBullets)),
        const Separator(),
        Expanded(
          child: CodeSnippetsWidget(codeSnippets: data.codeSamples ?? []),
        ),
      ],
    );
  }
}

class SingleTextLayout extends StatelessWidget {
  final SlideData data;

  const SingleTextLayout({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TemplateSlide(
      title: data.title,
      subtitle: data.subtitle,
      child: BodyTextWidget(
        plainText: data.plainText,
        bullets: data.leftBullets,
      ),
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
      children: [
        Expanded(child: BodyTextWidget(bullets: data.leftBullets)),
        const Separator(),
        Expanded(child: BodyTextWidget(bullets: data.rightBullets)),
      ],
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
      children: [
        Expanded(child: BodyTextWidget(bullets: data.leftBullets)),
        const Separator(),
        Expanded(child: ImageWidget(imagePath: data.rightImagePath ?? '')),
      ],
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
      children: [
        Expanded(child: ImageWidget(imagePath: data.leftImagePath ?? '')),
        const Separator(),
        Expanded(child: BodyTextWidget(bullets: data.rightBullets)),
      ],
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
      children: [
        Expanded(child: ImageWidget(imagePath: data.leftImagePath ?? '')),
        const Separator(),
        Expanded(
          child: CodeSnippetsWidget(codeSnippets: data.codeSamples ?? []),
        ),
      ],
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
      children: [
        Expanded(
          child: CodeSnippetsWidget(codeSnippets: data.codeSamples ?? []),
        ),
        const Separator(),
        Expanded(child: ImageWidget(imagePath: data.rightImagePath ?? '')),
      ],
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
      child: CodeSnippetsWidget(codeSnippets: data.codeSamples ?? []),
    );
  }
}

class DoubleCodeLayout extends StatelessWidget {
  final SlideData data;

  const DoubleCodeLayout({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TemplateSlide(
      title: data.title,
      subtitle: data.subtitle,
      children: [
        Expanded(
          child: CodeSnippetsWidget(codeSnippets: data.codeSamples ?? []),
        ),
        const Separator(),
        Expanded(
          child: CodeSnippetsWidget(codeSnippets: data.codeSamples ?? []),
        ),
      ],
    );
  }
}

class TextWithCodeLayout extends StatelessWidget {
  final SlideData data;

  const TextWithCodeLayout({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TemplateSlide(
      title: data.title,
      subtitle: data.subtitle,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: data.textWithCodePairs?.length ?? 0,
        separatorBuilder:
            (context, index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(),
            ),
        itemBuilder: (context, index) {
          final pair = data.textWithCodePairs![index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: BodyText(pair.text)),
              const Separator(),
              Expanded(
                flex: 4,
                child: CodeSnippetsWidget(codeSnippets: [pair.codeSample]),
              ),
            ],
          );
        },
      ),
    );
  }
}
