import 'package:flutter/material.dart';
import 'package:flutter_focus_fun/data_models/slide_data.dart';
import 'package:flutter_focus_fun/slides/template_slide.dart';
import 'package:flutter_focus_fun/slides/widgets/body_text.dart';
import 'package:flutter_focus_fun/slides/widgets/body_text_widget.dart';
import 'package:flutter_focus_fun/slides/widgets/code_snippets_widget.dart';
import 'package:flutter_focus_fun/slides/widgets/image_widget.dart';

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
        Expanded(
          flex: 5,
          child: BodyTextWidget(
            bullets: data.leftBullets,
            plainText: data.plainText,
          ),
        ),
        const Separator(),
        Expanded(
          flex: 4,
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
        Expanded(
          child: BodyTextWidget(
            bullets: data.leftBullets,
            plainText: data.plainText,
          ),
        ),
        const Separator(),
        Expanded(
          child: BodyTextWidget(
            bullets: data.rightBullets,
            plainText: data.plainText,
          ),
        ),
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
        Expanded(
          child: BodyTextWidget(
            bullets: data.leftBullets,
            plainText: data.plainText,
          ),
        ),
        const Separator(),
        Expanded(
          child: ImageWidget(
            imagePath: data.rightImagePath ?? '',
            useDarkVersion: data.rightImageInverted,
          ),
        ),
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
        Expanded(
          child: ImageWidget(
            imagePath: data.leftImagePath ?? '',
            useDarkVersion: data.leftImageInverted,
          ),
        ),
        const Separator(),
        Expanded(
          child: BodyTextWidget(
            bullets: data.rightBullets,
            plainText: data.plainText,
          ),
        ),
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
        Expanded(
          child: ImageWidget(
            imagePath: data.leftImagePath ?? '',
            useDarkVersion: data.leftImageInverted,
          ),
        ),
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
        Expanded(
          child: ImageWidget(
            imagePath: data.rightImagePath ?? '',
            useDarkVersion: data.rightImageInverted,
          ),
        ),
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

class SingleImageLayout extends StatelessWidget {
  final SlideData data;

  const SingleImageLayout({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TemplateSlide(
      title: data.title,
      subtitle: data.subtitle,
      child: Center(
        child: ImageWidget(
          imagePath: data.imagePath ?? '',
          useDarkVersion: data.imageInverted,
        ),
      ),
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

class SpeakerIntroLayout extends StatelessWidget {
  final SlideData data;

  const SpeakerIntroLayout({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TemplateSlide(
      title: data.title,
      subtitle: data.subtitle,
      children: [
        Expanded(
          flex: 2,
          child: ImageWidget(
            imagePath: data.leftImagePath ?? '',
            useDarkVersion: data.leftImageInverted,
          ),
        ),
        const SizedBox(width: 32),
        Expanded(flex: 3, child: BodyTextWidget(bullets: data.leftBullets)),
        const SizedBox(width: 32),
        Expanded(
          flex: 2,
          child: ImageWidget(
            imagePath: data.rightImagePath ?? '',
            useDarkVersion: data.rightImageInverted,
          ),
        ),
      ],
    );
  }
}
