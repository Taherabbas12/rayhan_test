import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
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
            // _buildDiscountSection(couponController),
            // const SizedBox(height: 12),
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

  Widget _buildDiscountSection(TextEditingController controller) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "الخصم على الطلبية",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "اكتب الكود هنا",
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: () {}, child: const Text("تحقق")),
              ],
            ),
            const Divider(height: 20),
            Row(
              children: [
                const Expanded(child: Text("200 نقطة")),
                Switch(
                  value: usePoints.value,
                  onChanged: (val) => usePoints.value = val,
                ),
                const Text("كل 100 نقطة = 1,000 د.ع"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsSection() {
    return Obx(() {
      double total = cartController.total.value;
      double delivery =
          cartController.selectedRestaurant.value?.deliveryPrice ?? 0;
      // double discount = 1000; // خصم المطعم
      double pointsDiscount = usePoints.value ? 2000 : 0;
      // double coupon = 4000;
      double serviceFee = 0;
      double totalFinal = total + delivery - pointsDiscount + serviceFee;

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
              child: Text("معلومات الدفع", style: StringStyle.headerStyle),
            ),
            const Divider(color: ColorApp.borderColor, height: 0),

            Padding(
              padding: EdgeInsets.all(Values.spacerV),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _priceRow("سعر الطلب", total),
                  _priceRow("التوصيل", delivery),
                  // _priceRow("خصم المطعم", -discount),
                  // _priceRow("خصم النقاط", -pointsDiscount),
                  // _priceRow("كوبون خصم", -coupon),
                  // _priceRow("أجور الخدمة", serviceFee),
                  const Divider(color: ColorApp.borderColor),
                  _priceRow("المبلغ الكلي", totalFinal, bold: true),
                ],
              ),
            ),
          ],
        ),
      );
    });
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

  Widget _priceRow(String title, double amount, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                bold
                    ? StringStyle.headerStyle.copyWith(
                      color: ColorApp.textSecondryColor,
                    )
                    : StringStyle.textLabil.copyWith(
                      color: ColorApp.textSecondryColor,
                    ),
          ),
          Text(
            "د.ع ${amount.toStringAsFixed(0)}",
            style:
                bold
                    ? StringStyle.headerStyle.copyWith(
                      color: ColorApp.textSecondryColor,
                    )
                    : StringStyle.textLabil.copyWith(
                      color: ColorApp.textSecondryColor,
                    ),
          ),
        ],
      ),
    );
  }
}
