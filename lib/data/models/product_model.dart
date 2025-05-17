class Product {
  final int id;
  final String name;
  final String descc;
  final String curncy;
  final bool active;
  final String count;
  final String image;
  final double price1;
  final double price2;

  final String shopType;

  Product({
    this.id = 0,
    this.name = '',
    this.descc = '',
    this.active = true,
    this.count = '',
    this.curncy = '',
    this.image = '',
    this.price1 = 0,
    this.price2 = 0,
    this.shopType = '',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      descc: json['descc'] ?? '',
      curncy: json['curncy'] ?? '',
      active: json['active'] ?? false,
      count: json['count'] ?? '0',
      image: json['image'] ?? json['img1'] ?? '',
      price1: _parseDouble(json['price1']),
      price2: _parseDouble(json['price2']),
      shopType: json['shopType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'descc': descc,
      'active': active,
      'count': count,
      'image': image,
      'price1': price1,
      'shopType': shopType,
    };
  }

  static List<Product> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }
}

double _parseDouble(dynamic value) {
  if (value == null) return 0.0;

  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;

  return 0.0;
}
