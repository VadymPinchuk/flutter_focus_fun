class CodeSnippet {
  final String title;
  final String code;

  CodeSnippet({this.title = '', required this.code});

  factory CodeSnippet.fromJson(Map<String, dynamic> json) {
    return CodeSnippet(
      title: json['title'] as String? ?? '',
      code: json['code'] as String,
    );
  }
}