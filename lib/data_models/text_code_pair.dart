import 'package:flutter_focus_fun_tv_demo/data_models/code_sample.dart';

/// A class to hold a text point and its associated code sample.
class TextCodePair {
  final String text;
  final CodeSnippet codeSample;

  TextCodePair({required this.text, required this.codeSample});

  factory TextCodePair.fromJson(Map<String, dynamic> json) {
    return TextCodePair(
      text: json['text'] as String,
      codeSample: CodeSnippet.fromJson(
        json['codeSample'] as Map<String, dynamic>,
      ),
    );
  }
}
