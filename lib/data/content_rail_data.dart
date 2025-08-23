import 'package:flutter_focus_fun_tv_demo/data/content_item.dart';
import 'package:uuid/uuid.dart' show Uuid;

const _uuid = Uuid();

class ContentRailData {
  final String id;
  final String title;
  final List<ContentItem> items;

  ContentRailData({required this.title, required this.items}) : id = _uuid.v4();
}
