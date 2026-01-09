import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/views/widgets/common/loading_indicator.dart';

import '../../../../controllers/cart_item_controller.dart';
import '../../../../controllers/my_address_controller.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/style_app.dart';
import '../../../../utils/constants/values_constant.dart';
import '../../../widgets/actions_button.dart';
import '../../../widgets/more_widgets.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});
  final CartItemController cartController = Get.find<CartItemController>();
  final MyAddressController myAddressController =
      Get.find<MyAddressController>();

  final RxBool usePoints = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إكمال الطلب")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildAddressSection(),
            const SizedBox(height: 12),
            _buildNoteSection(cartController.noteController),
            const SizedBox(height: 12),
            _buildPromoCodeSection(),
            const SizedBox(height: 12),
            _buildPaymentDetailsSection(),
            const SizedBox(height: 12),
            _buildPaymentInfoSection(),
            const SizedBox(height: 24),
            SizedBox(height: Values.height * .15),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: Values.spacerV * 2),
        child: Obx(
          () =>
              cartController.isLoadingOrder.value
                  ? LoadingIndicator()
                  : BottonsC.action1(h: 50, 'التالي', () {
                    cartController.submitOrderFromCart();
                  }, color: ColorApp.primaryColor),
        ),
      ),
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Values.circle),
              topRight: Radius.circular(Values.circle),
            ),
            border: Border(
              top: BorderSide(color: Colors.grey.shade300),
              left: BorderSide(color: Colors.grey.shade300),
              right: BorderSide(color: Colors.grey.shade300),
              bottom: BorderSide.none, // ✅ أخفينا الحد السفلي
            ),
          ),
          child: Text("عنوان التوصيل", style: StringStyle.headerStyle),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Values.circle),
              bottomRight: Radius.circular(Values.circle),
            ),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      myAddressController.addressSelect.value?.nickName ??
                          '...',
                    ),
                    SizedBox(width: Values.circle * .5),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ColorApp.subColor.withAlpha(70),
                        borderRadius: BorderRadius.circular(Values.circle),
                      ),
                      child: Text("الافتراضي"),
                    ),
                    Spacer(),
                    BottonsC.actionIcon(
                      Icons.edit,
                      'تعديل العنوان',
                      showAddressPicker,
                    ),
                  ],
                ),

                Text(
                  myAddressController.addressSelect.value?.toString() ?? '...',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoteSection(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Values.circle),

        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "ملاحظة عامة حول الطلبية",
              style: StringStyle.headerStyle,
            ),
          ),
          Divider(color: ColorApp.borderColor),

          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Values.circle),

              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextFormField(
              controller: controller,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "اكتب ملاحظتك هنا.",
                contentPadding: EdgeInsets.all(Values.circle),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Values.circle),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("كود الخصم (البروموكود)", style: StringStyle.headerStyle),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: cartController.couponController,
                    enabled: !cartController.isCouponApplied.value,
                    decoration: InputDecoration(
                      hintText: "أدخل كود الخصم",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: ColorApp.primaryColor),
                      ),
                      suffixIcon:
                          cartController.isCouponApplied.value
                              ? Icon(
                                Icons.check_circle,
                                color: ColorApp.greenColor,
                              )
                              : null,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (cartController.isCouponApplied.value)
                  ElevatedButton(
                    onPressed: () {
                      cartController.removeCoupon();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "إزالة",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                else
                  ElevatedButton(
                    onPressed:
                        cartController.isLoadingCheckOrder.value
                            ? null
                            : () {
                              if (cartController
                                  .couponController
                                  .text
                                  .isNotEmpty) {
                                cartController.checkOrder(
                                  couponCode:
                                      cartController.couponController.text
                                          .trim(),
                                );
                              }
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorApp.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    child:
                        cartController.isLoadingCheckOrder.value
                            ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : const Text(
                              "تحقق",
                              style: TextStyle(color: Colors.white),
                            ),
                  ),
              ],
            ),
            // عرض رسالة الخطأ
            if (cartController.couponError.value.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  cartController.couponError.value,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            // عرض معلومات الخصم عند التطبيق الناجح
            if (cartController.isCouponApplied.value &&
                cartController.checkOrderResult.value != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ColorApp.greenColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: ColorApp.greenColor.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_offer,
                        color: ColorApp.greenColor,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "خصم الكوبون: ${cartController.checkOrderResult.value!.coponDiscount.toStringAsFixed(0)} د.ع",
                        style: TextStyle(
                          color: ColorApp.greenColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsSection() {
    return Obx(() {
      final checkResult = cartController.checkOrderResult.value;

      // القيم الأساسية من السلة (دائماً محسوبة محلياً)
      double orderPrice = cartController.total.value;
      double tax = orderPrice * 0.05; // ضريبة 5%
      double delivery =
          cartController.selectedRestaurant.value?.deliveryPrice ??
          cartController.homeGetAllController.deleveryPrice.value.toDouble();

      // استخدام قيم API فقط إذا كانت أكبر من صفر، وإلا نستخدم القيم المحلية
      double displayOrderPrice =
          (checkResult?.orderPrice ?? 0) > 0
              ? checkResult!.orderPrice
              : orderPrice;
      double displayTax = (checkResult?.tax ?? 0) > 0 ? checkResult!.tax : tax;
      double displayDelivery =
          (checkResult?.newDeliveryPrice ?? 0) > 0
              ? checkResult!.newDeliveryPrice
              : delivery;
      double oldDeliveryPrice =
          (checkResult?.oldDeliveryPrice ?? 0) > 0
              ? checkResult!.oldDeliveryPrice
              : delivery;

      // الخصومات والرسوم من API
      double serviceFee = checkResult?.serviceFee ?? 0;
      double couponDiscount = checkResult?.coponDiscount ?? 0;
      double shopDiscount = checkResult?.shopDiscount ?? 0;
      double pointsDiscount = checkResult?.pointPriceDiscount ?? 0;

      // حساب السعر النهائي
      double calculatedFinal =
          displayOrderPrice +
          displayTax +
          displayDelivery +
          serviceFee -
          couponDiscount -
          shopDiscount -
          pointsDiscount;

      // استخدام السعر النهائي من API فقط إذا كان أكبر من صفر
      double finalPrice =
          (checkResult?.finalPrice ?? 0) > 0
              ? checkResult!.finalPrice
              : calculatedFinal;

      // هل يوجد خصم على التوصيل؟
      bool hasDeliveryDiscount =
          checkResult != null &&
          checkResult.hasDeliveryDiscount &&
          checkResult.oldDeliveryPrice > 0;

      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Values.circle),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(Values.spacerV),
              child: Text("تفاصيل الفاتورة", style: StringStyle.headerStyle),
            ),
            const Divider(color: ColorApp.borderColor, height: 0),

            Padding(
              padding: EdgeInsets.all(Values.spacerV),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // سعر الطلب الأساسي
                  _priceRow("سعر المنتجات", displayOrderPrice),

                  // التوصيل مع الخصم إن وجد
                  if (hasDeliveryDiscount)
                    _priceRowWithDiscount(
                      "التوصيل",
                      oldDeliveryPrice,
                      displayDelivery,
                    )
                  else
                    _priceRow("التوصيل", displayDelivery),

                  // الضريبة
                  _priceRow("الضريبة (5%)", displayTax),

                  // رسوم الخدمة
                  if (serviceFee > 0) _priceRow("رسوم الخدمة", serviceFee),

                  // خط فاصل قبل الخصومات
                  if (couponDiscount > 0 ||
                      shopDiscount > 0 ||
                      pointsDiscount > 0) ...[
                    const SizedBox(height: 8),
                    Text(
                      "الخصومات",
                      style: StringStyle.textLabil.copyWith(
                        color: ColorApp.greenColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],

                  // خصم المتجر
                  if (shopDiscount > 0)
                    _priceRow("خصم المتجر", -shopDiscount, isDiscount: true),

                  // خصم الكوبون
                  if (couponDiscount > 0)
                    _priceRow(
                      "خصم الكوبون ${checkResult?.coponName != null ? '(${checkResult!.coponName})' : ''}",
                      -couponDiscount,
                      isDiscount: true,
                    ),

                  // خصم النقاط
                  if (pointsDiscount > 0)
                    _priceRow("خصم النقاط", -pointsDiscount, isDiscount: true),

                  const Divider(color: ColorApp.borderColor),

                  // المبلغ الكلي
                  _priceRow("المبلغ الإجمالي", finalPrice, bold: true),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  /// عرض صف السعر مع خصم (سعر قديم مشطوب وسعر جديد)
  Widget _priceRowWithDiscount(String title, double oldPrice, double newPrice) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: StringStyle.textLabil.copyWith(
              color: ColorApp.textSecondryColor,
            ),
          ),
          Row(
            children: [
              Text(
                "د.ع ${oldPrice.toStringAsFixed(0)}",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "د.ع ${newPrice.toStringAsFixed(0)}",
                style: TextStyle(
                  color: ColorApp.greenColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfoSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Values.circle),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(Values.spacerV),
            child: Text("المعلومات العامة", style: StringStyle.headerStyle),
          ),
          const Divider(color: ColorApp.borderColor, height: 0),

          Padding(
            padding: EdgeInsets.all(Values.spacerV),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "المعلومات العامة",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "طريقة الدفع: كاش",
                  style: StringStyle.headerStyle.copyWith(
                    color: ColorApp.textSecondryColor,
                  ),
                ),
                // Text("رقم المعاملة: SK7263727399"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceRow(
    String title,
    double amount, {
    bool bold = false,
    bool isDiscount = false,
  }) {
    // تحديد اللون بناءً على نوع السعر
    Color textColor;
    if (isDiscount) {
      textColor = ColorApp.greenColor;
    } else if (bold) {
      textColor = ColorApp.textSecondryColor;
    } else {
      textColor = ColorApp.textSecondryColor;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                bold
                    ? StringStyle.headerStyle.copyWith(color: textColor)
                    : StringStyle.textLabil.copyWith(color: textColor),
          ),
          Text(
            "د.ع ${amount.toStringAsFixed(0)}",
            style:
                bold
                    ? StringStyle.headerStyle.copyWith(color: textColor)
                    : StringStyle.textLabil.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}
