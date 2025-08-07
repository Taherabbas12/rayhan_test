import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import 'package:rayhan_test/views/widgets/input_text.dart';
import '../../../../controllers/taxi_controller.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';
import '../../../../utils/validators.dart';

class OutsideBismayah extends StatelessWidget {
  OutsideBismayah({super.key});
  final TaxiController taxiController = Get.find<TaxiController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isStart = !taxiController.isCompleteStartingPoint.value;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: Values.spacerV),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('عنوانك التفصيلي', style: StringStyle.headerStyle),
            SizedBox(height: Values.spacerV),
            InputText.inputStringValidator(
              maxLine: 6,
              'يُرجى ذكر العنوان التفصيلي واقرب نقطة دالة.',
              isStart
                  ? taxiController.startingPointController
                  : taxiController.endPointController,
              validator:
                  (value) => Validators.notEmpty(
                    value,
                    isStart ? 'نقطة الانطلاق' : 'نقطة الوصول',
                  ),
            ),
            // SizedBox(height: Values.circle * 2),

            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: Values.circle * 2.4),
            //   decoration: BoxDecoration(
            //     color: ColorApp.borderColor.withAlpha(50),
            //     borderRadius: BorderRadius.circular(Values.circle),
            //   ),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       recent(taxiController.addressType[0]),
            //       recent(taxiController.addressType[1]),
            //     ],
            //   ),
            // ),
            // SizedBox(height: Values.circle * 2),
            // Obx(
            //   () =>
            //       taxiController.selectedAddressType.value ==
            //               taxiController.addressType[0]
            //           ? SizedBox()
            //           // ? RecentAddress()
            //           : notRecentAddress(),
            // ),
          ],
        ),
      );
    });
  }

  Widget notRecentAddress() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        height: 35,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(Values.circle),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 104,
              height: 104,
              decoration: BoxDecoration(
                border: Border.all(color: ColorApp.borderColor),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.access_time,
                color: ColorApp.backgroundColorContent,
                size: 50,
              ),
            ),
            SizedBox(height: Values.circle * 3),
            Text(
              'لا يوجد مدخلات أخيرة',
              style: StringStyle.headLineStyle2.copyWith(
                color: ColorApp.backgroundColorContent,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget recent(String title) {
    return Expanded(
      child: InkWell(
        onTap: () => taxiController.onAddressTypeChanged(title),
        child: Obx(
          () => Container(
            alignment: Alignment.center,
            height: 35,
            decoration: BoxDecoration(
              color:
                  taxiController.selectedAddressType.value == title
                      ? ColorApp.primaryColor
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(Values.circle),
            ),
            child: Text(
              title,
              style: StringStyle.textLabil.copyWith(
                color:
                    taxiController.selectedAddressType.value != title
                        ? ColorApp.backgroundColorContent
                        : ColorApp.whiteColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
