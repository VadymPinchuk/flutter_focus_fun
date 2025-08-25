class CodeSnippet {
  final String title;
  final String code;

  CodeSnippet._({this.title = '', required this.code});

  factory CodeSnippet.fromJson(Map<String, dynamic> json) {
    return CodeSnippet._(
      title: json['title'] as String? ?? '',
      code: json['code'] as String,
    );
  }
}