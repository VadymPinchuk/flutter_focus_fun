class CodeSample {
  final String title;
  final String code;

  CodeSample({this.title = '', required this.code});

  factory CodeSample.fromJson(Map<String, dynamic> json) {
    return CodeSample(
      title: json['title'] as String? ?? '',
      code: json['code'] as String,
    );
  }
}