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
