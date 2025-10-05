class CartItem {
  final int? id;
  final String productId;
  final String name;
  final String note;
  final double price1;
  final double price2;

  final int quantity;
  final String image;
  final String vendorId;
  final String vendorName;
  final CartType cartType;

  CartItem({
    this.id,
    required this.productId,
    required this.name,
    required this.note,
    required this.price1,
    required this.price2,
    required this.quantity,
    required this.image,
    required this.vendorId,
    required this.vendorName,
    required this.cartType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'note': note,
      'price1': price1,
      'price2': price2,
      'quantity': quantity,
      'image': image,
      'vendorId': vendorId,
      'vendorName': vendorName,
      'cartType': cartTypeToString(cartType), // حفظ كـ String
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      productId: map['productId'],
      name: map['name'],
      note: map['note'] ?? '',
      price1: map['price1'],
      price2: map['price2'],
      quantity: map['quantity'],
      image: map['image'],
      vendorId: map['vendorId'],
      vendorName: map['vendorName'],
      cartType: cartTypeFromString(map['cartType']),
    );
  }
  CartItem copyWith({
    int? id,
    String? productId,
    String? name,
    String? note,
    double? price1,
    double? price2,
    int? quantity,
    String? image,
    String? vendorId,
    String? vendorName,
    CartType? cartType,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      note: note ?? this.note,
      price1: price1 ?? this.price1,
      price2: price2 ?? this.price2,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
      vendorId: vendorId ?? this.vendorId,
      vendorName: vendorName ?? this.vendorName,
      cartType: cartType ?? this.cartType,
    );
  }
}

enum CartType { restaurant, shop, mart, service, taxi }

String cartTypeToString(CartType type) {
  switch (type) {
    case CartType.restaurant:
      return 'restaurant';
    case CartType.shop:
      return 'shop';
    case CartType.mart:
      return 'mart';
    case CartType.service:
      return 'service';
    case CartType.taxi:
      return 'taxi';
  }
}

CartType cartTypeFromString(String value) {
  switch (value) {
    case 'restaurant':
      return CartType.restaurant;
    case 'shop':
      return CartType.shop;
    case 'mart':
      return CartType.mart;
    case 'service':
      return CartType.service;
    case 'taxi':
      return CartType.taxi;
    default:
      throw Exception('Invalid cart type');
  }
}
