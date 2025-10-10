class OrderServiceModel {
  int id;
  String name;
  String phone;
  int userId;
  String date;
  double totalPrice;
  String status;
  String orderType;
  int count;
  int? driverId;
  String deviceUser;
  String? deviceDriver;
  String deviceServiceProvider;
  int serviceProviderId;
  int addressId;
  double tax;
  double deliveryPrice;
  bool serviceProviderAccountDone;
  String userNote;
  String orderno;
  int? promoId;
  int mainCategoryId;
  bool needSeen;
  bool isSeen;
  String deliveryDate;
  String receiveDate;
  String seenDate;
  String deliveryTime;
  String receiveTime;
  String seenTime;

  OrderServiceModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.userId,
    required this.date,
    required this.totalPrice,
    required this.status,
    required this.orderType,
    required this.count,
    required this.deviceUser,
    required this.deviceServiceProvider,
    required this.serviceProviderId,
    required this.addressId,
    required this.tax,
    required this.deliveryPrice,
    required this.serviceProviderAccountDone,
    required this.userNote,
    required this.orderno,
    required this.mainCategoryId,
    required this.needSeen,
    required this.isSeen,
    required this.deliveryDate,
    required this.receiveDate,
    required this.seenDate,
    required this.deliveryTime,
    required this.receiveTime,
    required this.seenTime,
    this.driverId,
    this.deviceDriver,
    this.promoId,
  });
  static List<OrderServiceModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .where((json) => json['order'] != null)
        .map((json) => OrderServiceModel.fromJson(json['order']))
        .toList();
  }

  factory OrderServiceModel.fromJson(Map<String, dynamic> json) {
    return OrderServiceModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      userId: json['userId'] ?? 0,
      date: json['date'] ?? '',
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      orderType: json['orderType'] ?? '',
      count: json['count'] ?? 0,
      driverId: json['driverId'],
      deviceUser: json['deviceUser'] ?? '',
      deviceDriver: json['deviceDriver'],
      deviceServiceProvider: json['deviceServiceProvider'] ?? '',
      serviceProviderId: json['serviceProviderId'] ?? 0,
      addressId: json['addressId'] ?? 0,
      tax: (json['tax'] ?? 0).toDouble(),
      deliveryPrice: (json['deliveryPrice'] ?? 0).toDouble(),
      serviceProviderAccountDone: json['serviceProviderAccountDone'] ?? false,
      userNote: json['userNote'] ?? '',
      orderno: json['orderno'] ?? '',
      promoId: json['promoId'],
      mainCategoryId: json['mainCategoryId'] ?? 0,
      needSeen: json['needSeen'] ?? false,
      isSeen: json['isSeen'] ?? false,
      deliveryDate: json['deliveryDate'] ?? '',
      receiveDate: json['receiveDate'] ?? '',
      seenDate: json['seenDate'] ?? '',
      deliveryTime: json['deliveryTime'] ?? '',
      receiveTime: json['receiveTime'] ?? '',
      seenTime: json['seenTime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'userId': userId,
      'date': date,
      'totalPrice': totalPrice,
      'status': status,
      'orderType': orderType,
      'count': count,
      'driverId': driverId,
      'deviceUser': deviceUser,
      'deviceDriver': deviceDriver,
      'deviceServiceProvider': deviceServiceProvider,
      'serviceProviderId': serviceProviderId,
      'addressId': addressId,
      'tax': tax,
      'deliveryPrice': deliveryPrice,
      'serviceProviderAccountDone': serviceProviderAccountDone,
      'userNote': userNote,
      'orderno': orderno,
      'promoId': promoId,
      'mainCategoryId': mainCategoryId,
      'needSeen': needSeen,
      'isSeen': isSeen,
      'deliveryDate': deliveryDate,
      'receiveDate': receiveDate,
      'seenDate': seenDate,
      'deliveryTime': deliveryTime,
      'receiveTime': receiveTime,
      'seenTime': seenTime,
    };
  }
}
