class FavoriteProduct {
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

  final int vendorId;
  final String vendorName;

  FavoriteProduct({
    required this.id,
    required this.name,
    required this.descc,
    required this.curncy,
    required this.active,
    required this.count,
    required this.image,
    required this.price1,
    required this.price2,
    required this.shopType,
    required this.vendorId,
    required this.vendorName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'descc': descc,
      'curncy': curncy,
      'active': active ? 1 : 0,
      'count': count,
      'image': image,
      'price1': price1,
      'price2': price2,
      'shopType': shopType,
      'vendorId': vendorId,
      'vendorName': vendorName,
    };
  }

  factory FavoriteProduct.fromMap(Map<String, dynamic> map) {
    return FavoriteProduct(
      id: map['id'],
      name: map['name'],
      descc: map['descc'],
      curncy: map['curncy'],
      active: map['active'] == 1,
      count: map['count'],
      image: map['image'],
      price1: map['price1'],
      price2: map['price2'],
      shopType: map['shopType'],
      vendorId: int.tryParse(map['vendorId'].toString()) ?? 0,
      vendorName: map['vendorName'],
    );
  }
}
