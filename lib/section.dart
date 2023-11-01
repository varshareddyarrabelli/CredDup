import 'package:credmint/SelectionProperties.dart';
class Section {
  final String id;
  final SectionProperties sectionProperties;

  Section({
    required this.id,
    required this.sectionProperties,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      sectionProperties: SectionProperties.fromJson(json['section_properties']),
    );
  }
}