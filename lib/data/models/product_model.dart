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
    required this.id,
    required this.name,
    required this.descc,
    required this.active,
    required this.count,
    required this.image,
    required this.price1,
    required this.price2,
    required this.shopType,
  });

  // https://rayhan.shop/api/Shop/$shopId
  // https://rayhan.shop/api/ShopProduct/ForUser?page=1&pageSize=20&categoryId=38

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      descc: json['descc'],
      active: json['active'],
      count: json['count'],
      image: json['image'],
      price1: json['price1'].toDouble(),
      price2: json['price2'] != null ? json['price2'].toDouble() : 0.0,
      shopType: json['shopType'],
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
