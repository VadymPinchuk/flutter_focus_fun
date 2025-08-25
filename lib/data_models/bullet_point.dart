class BulletPoint {
  final String title;
  final String? description;

  BulletPoint._({required this.title, this.description});

  factory BulletPoint.fromJson(Map<String, dynamic> json) {
    return BulletPoint._(
      title: json['title'] as String,
      description: json['description'] as String?,
    );
  }
}
