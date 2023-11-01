class DisplayData {
  String name;
  String description;
  String iconUrl;

  DisplayData({
    required this.name,
    required this.description,
    required this.iconUrl,
  });

  factory DisplayData.fromJson(Map<String, dynamic> json) {
    return DisplayData(
      name: json['name'],
      description: json['description'],
      iconUrl: json['icon_url'],
    );
  }
}


