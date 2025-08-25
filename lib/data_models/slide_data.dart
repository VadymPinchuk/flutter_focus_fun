import 'package:flutter_focus_fun_tv_demo/data_models/bullet_point.dart';
import 'package:flutter_focus_fun_tv_demo/data_models/code_snippet.dart';
import 'package:flutter_focus_fun_tv_demo/data_models/slide_types.dart';
import 'package:flutter_focus_fun_tv_demo/data_models/text_code_pair.dart';

class SlideData {
  final String title;
  final String subtitle;
  final SlideType slideType;
  final List<String>? plainText;
  final List<BulletPoint>? leftBullets;
  final List<BulletPoint>? rightBullets;
  final String? rightImagePath;
  final String? leftImagePath;
  final String? fullWidthImagePath;
  final List<CodeSnippet>? codeSamples;
  final List<TextCodePair>? textWithCodePairs; // New field

  SlideData({
    required this.title,
    required this.subtitle,
    required this.slideType,
    this.plainText,
    this.leftBullets,
    this.rightBullets,
    this.rightImagePath,
    this.leftImagePath,
    this.fullWidthImagePath,
    this.codeSamples,
    this.textWithCodePairs,
  });

  factory SlideData.fromJson(Map<String, dynamic> json) {
    return SlideData(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      slideType: _slideTypeFromString(json['slideType'] as String?),
      plainText:
          (json['plainText'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      leftBullets:
          (json['leftBullets'] as List<dynamic>?)
              ?.map((e) => BulletPoint.fromJson(e as Map<String, dynamic>))
              .toList(),
      rightBullets:
          (json['rightBullets'] as List<dynamic>?)
              ?.map((e) => BulletPoint.fromJson(e as Map<String, dynamic>))
              .toList(),
      rightImagePath: json['rightImagePath'] as String?,
      leftImagePath: json['leftImagePath'] as String?,
      fullWidthImagePath: json['fullWidthImagePath'] as String?,
      codeSamples:
          (json['codeSamples'] as List<dynamic>?)
              ?.map((e) => CodeSnippet.fromJson(e as Map<String, dynamic>))
              .toList(),
      textWithCodePairs:
          (json['textWithCodePairs'] as List<dynamic>?)
              ?.map((e) => TextCodePair.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }
}

SlideType _slideTypeFromString(String? type) {
  switch (type) {
    case 'SINGLE_TEXT':
      return SlideType.singleText;
    case 'DOUBLE_TEXT':
      return SlideType.doubleText;
    case 'LEFT_TEXT_RIGHT_IMAGE':
      return SlideType.leftTextRightImage;
    case 'LEFT_TEXT_RIGHT_CODE':
      return SlideType.leftTextRightCode;
    case 'LEFT_IMAGE_RIGHT_TEXT':
      return SlideType.leftImageRightText;
    case 'LEFT_IMAGE_RIGHT_CODE':
      return SlideType.leftImageRightCode;
    case 'LEFT_CODE_RIGHT_IMAGE':
      return SlideType.leftCodeRightImage;
    case 'SINGLE_CODE':
      return SlideType.singleCode;
    case 'DOUBLE_CODE':
      return SlideType.doubleCode;
    case 'PLAIN_TEXT':
      return SlideType.plainText;
    case 'TEXT_WITH_CODE':
      return SlideType.textWithCode;
    default:
      return SlideType.unknown;
  }
}
