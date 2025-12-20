import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../controllers/cart_item_controller.dart';
import '../../../../../controllers/my_address_controller.dart';
import '../../../../../utils/constants/color_app.dart';
import '../../../../../utils/constants/style_app.dart';
import '../../../../../utils/constants/values_constant.dart';
import '../../../../widgets/actions_button.dart';
import '../../../../widgets/message_snak.dart';
import '../../../../widgets/more_widgets.dart';

class OrderScreenService extends StatelessWidget {
  OrderScreenService({super.key});

  final CartItemController cartController = Get.find<CartItemController>();

  final RxBool showGeneral = true.obs;
  final RxBool showAddress = true.obs;
  final RxBool showNote = false.obs;
  final RxBool showPaymentDetails = false.obs;
  final RxBool showPaymentInfo = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text("إكمال الطلب")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildAccordionCard(
              "المعلومات العامة",
              showGeneral,
              _buildGeneralInfoSection(),
            ),
            const SizedBox(height: 12),
            _buildAccordionCard(
              "عنوان التوصيل",
              showAddress,
              _buildAddressSection(),
            ),
            const SizedBox(height: 12),
            _buildAccordionCard("ملاحظات الطلب", showNote, _buildNoteSection()),
            const SizedBox(height: 12),
            _buildAccordionCard(
              "تفاصيل الدفع",
              showPaymentDetails,
              _buildPaymentDetailsSection(),
            ),
            const SizedBox(height: 12),
            // _buildAccordionCard(
            //   "معلومات الدفع",
            //   showPaymentInfo,
            //   _buildPaymentInfoSection(),
            // ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: Values.spacerV * 2),
        child: BottonsC.action1(
          h: 50,
          'التالي',
          () => cartController.submitOrderServiceFromCart(),
          color: ColorApp.primaryColor,
        ),
      ),
    );
  }

  /// 🟩 بطاقة مستقلة لكل قسم
  Widget _buildAccordionCard(String title, RxBool toggle, Widget content) {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Values.circle),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () => toggle.value = !toggle.value,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Values.circle),
                    topRight: Radius.circular(Values.circle),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: StringStyle.headerStyle),
                    AnimatedRotation(
                      turns: toggle.value ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.expand_more,
                        color: ColorApp.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 250),
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: content,
              ),
              crossFadeState:
                  toggle.value
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
            ),
          ],
        ),
      ),
    );
  }

  // 📋 المعلومات العامة
  Widget _buildGeneralInfoSection() {
    return Column(
      children: [
        _infoRow("يوم التسليم", cartController.selectedDay.value),
        SizedBox(height: Values.circle),
        _infoRow("ساعات التسليم", cartController.selectedTime.value),
        _infoRow("طريقة الدفع", "كاش"),
        _infoRow(
          "حالة الطلب",
          "بإنتظار التسعير",
          badgeColor: ColorApp.primaryColor,
        ),
      ],
    );
  }

  Widget _infoRow(
    String title,
    String value, {
    IconData? icon,
    Color? badgeColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
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
              if (badgeColor != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    // color: badgeColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(Values.circle * .6),
                    border: Border.all(color: badgeColor),
                  ),
                  child: Text(
                    value,
                    style: TextStyle(
                      color: badgeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                )
              else
                Text(
                  value,
                  style: StringStyle.textLabil.copyWith(
                    color: ColorApp.textSecondryColor,
                  ),
                ),
              if (icon != null)
                IconButton(
                  icon: Icon(icon, size: 18, color: ColorApp.primaryColor),
                  onPressed:
                      () => MessageSnak.message('تم نسخ رقم العملية بنجاح'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  final MyAddressController myAddressController =
      Get.find<MyAddressController>();

  // 🏠 العنوان
  Widget _buildAddressSection() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(myAddressController.addressSelect.value?.nickName ?? '...'),
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
    );
  }

  // 📝 الملاحظات
  Widget _buildNoteSection() {
    return TextFormField(
      controller: cartController.noteController,
      maxLines: 3,
      decoration: const InputDecoration(
        hintText: "اكتب ملاحظتك هنا...",
        border: InputBorder.none,
      ),
    );
  }

  // 💰 تفاصيل الدفع
  Widget _buildPaymentDetailsSection() {
    double total = cartController.total.value;
    double delivery =
        cartController.selectedRestaurant.value?.deliveryPrice ??
        cartController.homeGetAllController.deleveryPrice.value.toDouble();
    double totalFinal = total + delivery;

    return Column(
      children: [
        _priceRow("سعر الطلب", total),
        _priceRow("التوصيل", delivery),
        const Divider(),
        _priceRow("المجموع النهائي", totalFinal, bold: true),
      ],
    );
  }

  Widget _priceRow(String title, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                bold
                    ? StringStyle.headerStyle
                    : StringStyle.textLabil.copyWith(
                      color: ColorApp.textSecondryColor,
                    ),
          ),
          Text(
            "د.ع ${value.toStringAsFixed(0)}",
            style:
                bold
                    ? StringStyle.headerStyle
                    : StringStyle.textLabil.copyWith(
                      color: ColorApp.textSecondryColor,
                    ),
          ),
        ],
      ),
    );
  }
}
