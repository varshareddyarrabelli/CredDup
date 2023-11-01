import 'package:credmint/Item.dart';
class SectionProperties {
  final String title;
  final List<Item> items;

  SectionProperties({
    required this.title,
    required this.items,
  });

  factory SectionProperties.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List<dynamic>;
    final items = itemsList.map((itemJson) => Item.fromJson(itemJson)).toList();

    return SectionProperties(
      title: json['title'],
      items: items,
    );
  }
}