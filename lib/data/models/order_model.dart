class OrderModel {
  final int? id;
  final bool? needReview;
  final String? orderNo;
  final int? branch;
  final int? addressId;
  final String? shopName;
  final String? status;
  final String? image;
  final String? total;
  final String? delivery;
  final String? tax;
  final String? finalPrice;
  final String? driverId;
  final String? driverName;
  final String? driverPhone;
  final String? driverImage;
  static List<OrderModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => OrderModel.fromJson(json)).toList();
  }

  OrderModel({
    this.id,
    this.needReview,
    this.orderNo,
    this.branch,
    this.addressId,
    this.shopName,
    this.status,
    this.image,
    this.total,
    this.delivery,
    this.tax,
    this.finalPrice,
    this.driverId,
    this.driverName,
    this.driverPhone,
    this.driverImage,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int?,
      needReview: json['needReview'] as bool?,
      orderNo: json['orderNo'] as String?,
      branch: json['branch'] as int?,
      addressId: json['addressId'] as int?,
      shopName: json['shopName'] as String?,
      status: json['status'] as String?,
      image: json['image'] as String?,
      total: json['total'] as String?,
      delivery: json['delivery'] as String?,
      tax: json['tax'] as String?,
      finalPrice: json['finalPrice'] as String?,
      driverId: json['driverId'] as String?,
      driverName: json['driverName'] as String?,
      driverPhone: json['driverPhone'] as String?,
      driverImage: json['driverImage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'needReview': needReview,
      'orderNo': orderNo,
      'branch': branch,
      'addressId': addressId,
      'shopName': shopName,
      'status': status,
      'image': image,
      'total': total,
      'delivery': delivery,
      'tax': tax,
      'finalPrice': finalPrice,
      'driverId': driverId,
      'driverName': driverName,
      'driverPhone': driverPhone,
      'driverImage': driverImage,
    };
  }
}

//

class OrderItem {
  final int id;
  final String prod;
  final int orderx;
  final DateTime date;
  final String? k1;
  final String? k2;
  final String? varField; // 'var' كلمة محجوزة، لذا غيّرنا الاسم
  final String comnt;
  final String price;
  final String? purchasePrice;
  final bool supplierAccountComplete;
  final String curncy;
  final String? shop;
  final String prodname;
  final String? img;
  final String note;
  final String type;
  static List<OrderItem> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => OrderItem.fromJson(json)).toList();
  }

  OrderItem({
    required this.id,
    required this.prod,
    required this.orderx,
    required this.date,
    this.k1,
    this.k2,
    this.varField,
    required this.comnt,
    required this.price,
    this.purchasePrice,
    required this.supplierAccountComplete,
    required this.curncy,
    this.shop,
    required this.prodname,
    this.img,
    required this.note,
    required this.type,
  });

  // من JSON إلى كائن Dart
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] as int,
      prod: json['prod'] as String,
      orderx: json['orderx'] as int,
      date: DateTime.parse(json['date'] as String),
      k1: json['k1'] as String?,
      k2: json['k2'] as String?,
      varField: json['var'] as String?, // استخدم 'var' في الـ JSON
      comnt: json['comnt'] as String,
      price: json['price'] as String,
      purchasePrice: json['purchasePrice'] as String?,
      supplierAccountComplete: json['supplierAccountComplete'] as bool,
      curncy: json['curncy'] as String,
      shop: json['shop'] as String?,
      prodname: json['prodname'] as String,
      img: json['img'] as String?,
      note: json['note'] as String,
      type: json['type'] as String,
    );
  }

  // من كائن Dart إلى JSON (مفيد للـ PATCH أو POST)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'prod': prod,
      'orderx': orderx,
      'date': date.toIso8601String(),
      'k1': k1,
      'k2': k2,
      'var': varField, // نُخرِجها كـ "var" في JSON
      'comnt': comnt,
      'price': price,
      'purchasePrice': purchasePrice,
      'supplierAccountComplete': supplierAccountComplete,
      'curncy': curncy,
      'shop': shop,
      'prodname': prodname,
      'img': img,
      'note': note,
      'type': type,
    };
  }
}
