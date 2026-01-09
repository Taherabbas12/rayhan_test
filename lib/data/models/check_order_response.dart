/// نموذج استجابة التحقق من الطلب (CheckOrder)
class CheckOrderResponse {
  final double totalPrice;
  final double orderPrice;
  final double tax;
  final String? coponName;
  final double coponDiscount;
  final String? coponType;
  final double oldDeliveryPrice;
  final double newDeliveryPrice;
  final double pointPriceDiscount;
  final double pointPriceDiscountUseing;
  final List<String> typeOfDeiscount;
  final double shopDiscount;
  final double finalPrice;
  final double serviceFee;

  CheckOrderResponse({
    required this.totalPrice,
    required this.orderPrice,
    required this.tax,
    this.coponName,
    required this.coponDiscount,
    this.coponType,
    required this.oldDeliveryPrice,
    required this.newDeliveryPrice,
    required this.pointPriceDiscount,
    required this.pointPriceDiscountUseing,
    required this.typeOfDeiscount,
    required this.shopDiscount,
    required this.finalPrice,
    required this.serviceFee,
  });

  factory CheckOrderResponse.fromJson(Map<String, dynamic> json) {
    return CheckOrderResponse(
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      orderPrice: (json['orderPrice'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      coponName: json['coponName'],
      coponDiscount: (json['coponDiscount'] ?? 0).toDouble(),
      coponType: json['coponType'],
      oldDeliveryPrice: (json['oldDeliveryPrice'] ?? 0).toDouble(),
      newDeliveryPrice: (json['newDeliveryPrice'] ?? 0).toDouble(),
      pointPriceDiscount: (json['pointPriceDiscount'] ?? 0).toDouble(),
      pointPriceDiscountUseing:
          (json['pointPriceDiscountUseing'] ?? 0).toDouble(),
      typeOfDeiscount: List<String>.from(json['typeOfDeiscount'] ?? []),
      shopDiscount: (json['shopDiscount'] ?? 0).toDouble(),
      finalPrice: (json['finalPrice'] ?? 0).toDouble(),
      serviceFee: (json['serviceFee'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalPrice': totalPrice,
      'orderPrice': orderPrice,
      'tax': tax,
      'coponName': coponName,
      'coponDiscount': coponDiscount,
      'coponType': coponType,
      'oldDeliveryPrice': oldDeliveryPrice,
      'newDeliveryPrice': newDeliveryPrice,
      'pointPriceDiscount': pointPriceDiscount,
      'pointPriceDiscountUseing': pointPriceDiscountUseing,
      'typeOfDeiscount': typeOfDeiscount,
      'shopDiscount': shopDiscount,
      'finalPrice': finalPrice,
      'serviceFee': serviceFee,
    };
  }

  /// هل يوجد خصم كوبون؟
  bool get hasCouponDiscount => coponDiscount > 0;

  /// هل يوجد خصم متجر؟
  bool get hasShopDiscount => shopDiscount > 0;

  /// هل سعر التوصيل تغير؟
  bool get hasDeliveryDiscount => oldDeliveryPrice != newDeliveryPrice;

  /// هل يوجد خصم نقاط؟
  bool get hasPointDiscount => pointPriceDiscount > 0;

  /// هل يوجد رسوم خدمة؟
  bool get hasServiceFee => serviceFee > 0;

  /// إجمالي الخصومات
  double get totalDiscount =>
      coponDiscount +
      shopDiscount +
      pointPriceDiscount +
      (oldDeliveryPrice - newDeliveryPrice);
}
