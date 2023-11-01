import 'package:credmint/DisplayData.dart';

class Item {
  final String id;
  final DisplayData displayData;

  Item({
    required this.id,
    required this.displayData,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      displayData: DisplayData.fromJson(json['display_data']),
    );
  }
}
