class Product {
  final int id;
  final String name;
  final String descc;
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
    this.image = '',
    this.price1 = 0,
    this.price2 = 0,
    this.shopType = '',
  });

  // https://rayhan.shop/api/Shop/$shopId
  // https://rayhan.shop/api/ShopProduct/ForUser?page=1&pageSize=20&categoryId=38

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      descc: json['descc'] ?? '',
      active: json['active'] ?? false,
      count: json['count'] ?? '0',
      image: json['image'] ?? '',
      price1: (json['price1'] ?? 0).toDouble(),
      price2: (json['price2'] ?? 0).toDouble(),
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
