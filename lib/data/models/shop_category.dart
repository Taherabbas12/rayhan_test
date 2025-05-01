class ShopCategory {
  final int id;
  final String name;

  ShopCategory({required this.id, required this.name});

  factory ShopCategory.fromJson(Map<String, dynamic> json) {
    return ShopCategory(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  static List<ShopCategory> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ShopCategory.fromJson(json)).toList();
  }
}
