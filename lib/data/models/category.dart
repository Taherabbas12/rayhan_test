class Category {
  final int id;
  final String name;
  final String image;
  final String type;
  final String? sort;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    this.sort,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? json['img'] ?? '',
      type: json['type'] ?? '',
      sort: json['sort'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image, 'type': type};
  }

  static List<Category> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Category.fromJson(json)).toList();
  }
}
