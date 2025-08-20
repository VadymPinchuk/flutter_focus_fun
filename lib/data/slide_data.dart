enum SlideType {
  singleText,
  doubleText,
  leftTextRightImage,
  leftTextRightCode,
  leftImageRightText,
  leftImageRightCode,
  leftCodeRightImage,
  singleCode,
  unknown,
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
    default:
      return SlideType.unknown;
  }
}

class SlideFooterItem {
  final String text;
  final String imagePath;

  SlideFooterItem({required this.text, required this.imagePath});

  factory SlideFooterItem.fromJson(Map<String, dynamic> json) {
    return SlideFooterItem(
      text: json['text'] as String,
      imagePath: json['imagePath'] as String,
    );
  }
}

/// A class to hold a single code snippet with optional metadata.
class CodeSample {
  final String title;
  final String code;
  final String language;

  CodeSample({this.title = '', required this.code, this.language = 'dart'});

  factory CodeSample.fromJson(Map<String, dynamic> json) {
    return CodeSample(
      title: json['title'] as String? ?? '',
      code: json['code'] as String,
      language: json['language'] as String? ?? 'dart',
    );
  }
}

class SlideData {
  final String title;
  final String subtitle;
  final SlideType slideType;
  final List<String>? leftBullets;
  final List<String>? rightBullets;
  final String? rightImagePath;
  final String? leftImagePath;
  final String? fullWidthImagePath;
  final List<String>? codeSamples;
  final List<SlideFooterItem>? footers;

  SlideData({
    required this.title,
    required this.subtitle,
    required this.slideType,
    this.leftBullets,
    this.rightBullets,
    this.rightImagePath,
    this.leftImagePath,
    this.fullWidthImagePath,
    this.codeSamples,
    this.footers,
  });

  factory SlideData.fromJson(Map<String, dynamic> json) {
    return SlideData(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      slideType: _slideTypeFromString(json['slideType'] as String?),
      leftBullets:
          (json['leftBullets'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      rightBullets:
          (json['rightBullets'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      rightImagePath: json['rightImagePath'] as String?,
      leftImagePath: json['leftImagePath'] as String?,
      fullWidthImagePath: json['fullWidthImagePath'] as String?,
      codeSamples:
          (json['codeSamples'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      footers:
          (json['footer'] as List<dynamic>?)
              ?.map((e) => SlideFooterItem.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }
}
