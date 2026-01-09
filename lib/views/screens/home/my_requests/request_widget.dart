import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/images_url.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import 'package:rayhan_test/views/widgets/common/svg_show.dart';
import 'package:rayhan_test/views/widgets/more_widgets.dart';

import '../../../../controllers/my_request_controller.dart';
import '../../../../data/models/order_model.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';

class RequestWidget extends StatelessWidget {
  RequestWidget({super.key, required this.orderModel});
  final OrderModel orderModel;
  final MyRequestController myRequestController =
      Get.find<MyRequestController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Values.spacerV),
      padding: EdgeInsets.all(Values.spacerV),
      decoration: BoxDecoration(
        border: Border.all(color: ColorApp.borderColor),
        borderRadius: BorderRadius.circular(Values.circle),
      ),
      child: Column(
        children: [
          // الجزء العلوي - معلومات الطلب
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الصورة
              Container(
                padding: EdgeInsets.all(Values.circle * .2),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorApp.borderColor),
                  borderRadius: BorderRadius.circular(Values.circle),
                ),
                height: 70,
                width: 70,
                child: imageCached(
                  orderModel.image ?? 'url',
                  circle: Values.circle,
                  left: true,
                  down: true,
                  right: true,
                  top: true,
                ),
              ),
              SizedBox(width: Values.circle),
              // تفاصيل الطلب
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // حالة الطلب
                    Row(
                      children: [
                        svgImage(
                          ImagesUrl.infoSquareIcon,
                          padingValue: Values.circle * .5,
                          hi: 16,
                        ),
                        Text('حالة الطلب : ', style: StringStyle.textLabil),
                        Text(
                          getStatusName(orderModel.status!),
                          style: StringStyle.textLabil.copyWith(
                            color: ColorApp.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    // اسم المطعم
                    Text(
                      orderModel.shopName ?? 'ريحان',
                      style: StringStyle.headerStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    // رقم العملية والسعر
                    Row(
                      children: [
                        svgImage(ImagesUrl.ticketIcon, padingValue: 0, hi: 14),
                        SizedBox(width: 4),
                        Text(
                          'رقم العملية : ',
                          style: StringStyle.textLabil.copyWith(fontSize: 12),
                        ),
                        Text(
                          '${orderModel.orderNo}#',
                          style: StringStyle.textLabil.copyWith(
                            color: Color(0xff0CC25F),
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 8),
                        svgImage(
                          ImagesUrl.copperDiamondFillIcon,
                          padingValue: 0,
                          hi: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${formatCurrency(orderModel.finalPrice!)} د.ع',
                          style: StringStyle.textLabil.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: Values.circle),

          // الأزرار الثلاثة
          Row(
            children: [
              // زر الدعم
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // TODO: فتح صفحة الدعم
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: ColorApp.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Values.circle),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Text(
                    'الدعم',
                    style: StringStyle.textLabil.copyWith(
                      color: ColorApp.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              // زر تتبع
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.orderTrackingScreen);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: ColorApp.borderColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Values.circle),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Text(
                    'تتبع',
                    style: StringStyle.textLabil.copyWith(
                      color: ColorApp.textSecondryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              // زر التفاصيل
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (orderModel.id != null) {
                      myRequestController.fetchOrderDetails(
                        orderModel.id!,
                        order: orderModel,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorApp.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Values.circle),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Text(
                    'التفاصيل',
                    style: StringStyle.textLabil.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
