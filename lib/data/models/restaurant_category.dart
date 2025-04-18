class RestaurantCategory {
  final int id;
  final String name;
  final String image;
  final DateTime date;

  RestaurantCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.date,
  });

  factory RestaurantCategory.fromJson(Map<String, dynamic> json) {
    return RestaurantCategory(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'date': date.toIso8601String(),
    };
  }

  static List<RestaurantCategory> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => RestaurantCategory.fromJson(json)).toList();
  }
}
