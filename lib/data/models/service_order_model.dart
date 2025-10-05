import 'package:rayhan_test/data/models/product_model.dart';

class ServiceOrderModel {
  String? branch;
  String? tax;
  String? orderPrice;
  String? userId;
  String? addressId;
  String? totalPrice;
  String? deliveryPrice;
  String? mainCategoryId;
  String orderType;
  String? deliveryDays;
  String? receiveDays;
  String? seenDays;
  String? deliveryTime;
  String? receiveTimes;
  String? seenTimes;
  String? orderNote;
  List<String> images;
  List<Product> items;

  ServiceOrderModel({
    this.branch,
    this.tax,
    this.orderPrice,
    this.userId,
    this.addressId,
    this.totalPrice,
    this.deliveryPrice,
    this.mainCategoryId,
    this.deliveryDays,
    this.receiveDays,
    this.seenDays,
    this.deliveryTime,
    this.receiveTimes,
    this.seenTimes,
    this.orderNote,
    this.images = const [],
    this.items = const [],
    this.orderType = "Found",
  });

  factory ServiceOrderModel.fromJson(Map<String, dynamic> json) {
    return ServiceOrderModel(
      branch: json['branch'],
      tax: json['tax'],
      orderPrice: json['orderPrice'],
      userId: json['userId'],
      addressId: json['addressId'],
      totalPrice: json['totalPrice'],
      deliveryPrice: json['deliveryPrice'],
      mainCategoryId: json['mainCategoryId'],
      orderType: json['orderType'] ?? "Found",
      deliveryDays: json['deliveryDays'],
      receiveDays: json['receiveDays'],
      seenDays: json['seenDays'],
      deliveryTime: json['deliveryTime'],
      receiveTimes: json['receiveTimes'],
      seenTimes: json['seenTimes'],
      orderNote: json['orderNote'],
      images: List<String>.from(json['images'] ?? []),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "branch": branch,
      "tax": tax,
      "orderPrice": orderPrice,
      "userId": userId,
      "addressId": addressId,
      "totalPrice": totalPrice,
      "deliveryPrice": deliveryPrice,
      "mainCategoryId": mainCategoryId,
      "orderType": orderType,
      "deliveryDays": deliveryDays,
      "receiveDays": receiveDays,
      "seenDays": seenDays,
      "deliveryTime": deliveryTime,
      "receiveTimes": receiveTimes,
      "seenTimes": seenTimes,
      "orderNote": orderNote,
      "images": images,
      "items": items.map((e) => e.toJson()).toList(),
    };
  }
}
