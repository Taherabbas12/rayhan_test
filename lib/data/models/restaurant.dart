class Restaurant {
  final int id;
  final String categoryId;
  final String name;
  final String subName;
  final String deviceToken;
  final String type;
  final bool isOpen;
  final bool active;
  final String deliveryTime;
  final String tag;
  final String cover;
  final String logo;
  final String password;
  final String phone;
  final String address;
  final DateTime date;
  final double discount;
  final double deliveryPrice;
  final bool freeDelivery;
  final String openTime;
  final String closeTime;
  final double starAvg;

  Restaurant({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.subName,
    required this.deviceToken,
    required this.type,
    required this.isOpen,
    required this.active,
    required this.deliveryTime,
    required this.tag,
    required this.cover,
    required this.logo,
    required this.password,
    required this.phone,
    required this.address,
    required this.date,
    required this.discount,
    required this.deliveryPrice,
    required this.freeDelivery,
    required this.openTime,
    required this.closeTime,
    required this.starAvg,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    final shop = json['shop'];
    return Restaurant(
      id: shop['id'],
      categoryId: shop['categoryId'],
      name: shop['name'],
      subName: shop['subName'],
      deviceToken: shop['deviceToken'],
      type: shop['type'],
      isOpen: shop['isOpen'],
      active: shop['active'],
      deliveryTime: shop['deliveryTime'],
      tag: shop['tag'],
      cover: shop['cover'],
      logo: shop['logo'],
      password: shop['password'],
      phone: shop['phone'],
      address: shop['address'],
      date: DateTime.parse(shop['date']),
      discount: (shop['discount'] as num).toDouble(),
      deliveryPrice: (shop['deliveryPrice'] as num).toDouble(),
      freeDelivery: shop['freeDelivery'],
      openTime: shop['openTime'],
      closeTime: shop['closeTime'],
      starAvg: (json['starAvg'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shop': {
        'id': id,
        'categoryId': categoryId,
        'name': name,
        'subName': subName,
        'deviceToken': deviceToken,
        'type': type,
        'isOpen': isOpen,
        'active': active,
        'deliveryTime': deliveryTime,
        'tag': tag,
        'cover': cover,
        'logo': logo,
        'password': password,
        'phone': phone,
        'address': address,
        'date': date.toIso8601String(),
        'discount': discount,
        'deliveryPrice': deliveryPrice,
        'freeDelivery': freeDelivery,
        'openTime': openTime,
        'closeTime': closeTime,
      },
      'starAvg': starAvg,
    };
  }

  static List<Restaurant> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Restaurant.fromJson(json)).toList();
  }
}
