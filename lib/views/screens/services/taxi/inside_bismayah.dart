import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import 'package:rayhan_test/views/widgets/actions_button.dart';

import '../../../../controllers/taxi_controller.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';
import 'recent_address.dart';

class InsideBismayah extends StatelessWidget {
  const InsideBismayah({super.key});
  TaxiController get taxiController => Get.find<TaxiController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: Values.circle * 2.4),
            inputDropDown(
              hintText: 'اختر البلوك',
              labelText: 'البلوك',
              items:
                  taxiController.taxiAddresses
                      .map(
                        (e) => DropdownMenuItem(value: e, child: Text(e.name)),
                      )
                      .toList(),
              initialValue: taxiController.selectedTaxi.value,

              onChanged: taxiController.selectTaxi,
            ),
            SizedBox(width: Values.circle * 2),
            Obx(
              () =>
                  taxiController.selectedTaxi.value == null
                      ? Expanded(child: SizedBox())
                      : inputDropDown(
                        hintText: 'اختر البناية',
                        labelText: 'البناية',
                        items:
                            taxiController.selectedTaxi.value?.addresses
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        initialValue: taxiController.selectedTaxiAddress.value,

                        onChanged: taxiController.selectTaxiAddress,
                      ),
            ),

            SizedBox(width: Values.circle * 2.4),
          ],
        ),
        SizedBox(height: Values.circle * 2),
        Container(
          margin: EdgeInsets.symmetric(horizontal: Values.circle * 2.4),
          decoration: BoxDecoration(
            color: ColorApp.borderColor.withAlpha(50),
            borderRadius: BorderRadius.circular(Values.circle),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              recent(taxiController.addressType[0]),

              recent(taxiController.addressType[1]),
            ],
          ),
        ),
        SizedBox(height: Values.circle * 2),
        Obx(
          () =>
              taxiController.selectedAddressType.value ==
                      taxiController.addressType[0]
                  ? RecentAddress()
                  : notRecentAddress(),
        ),
        nextButton(onPressed: () {}),
      ],
    );
  }

  Widget inputDropDown({
    String? hintText,
    String? labelText,
    initialValue,
    items,
    onChanged,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(labelText, style: StringStyle.headerStyle),
            ),

          SizedBox(height: Values.circle),
          Container(
            height: 60,

            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: ColorApp.borderColor.withAlpha(50),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ColorApp.borderColor),
            ),
            child: DropdownButtonFormField(
              icon: Icon(CupertinoIcons.chevron_down),
              style: StringStyle.headerStyle,
              borderRadius: BorderRadius.circular(Values.circle),
              decoration: InputDecoration(
                border: InputBorder.none,

                hintText: hintText ?? 'اختر خيارًا',
              ),
              items: items,
              value: initialValue,
              onChanged: onChanged,
            ),
          ),
        ],
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

  //
  Widget nextButton({required VoidCallback onPressed, String? text}) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: ColorApp.whiteColor,
          border: Border(top: BorderSide(color: ColorApp.borderColor)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Values.circle * 2.4,
          vertical: Values.circle * 2.4,
        ),

        child: Obx(
          () => BottonsC.action1(
            text ?? 'التالي',
            onPressed,
            h: 58,
            elevation: 0,
            color:
                taxiController.selectedTaxiAddress.value != null
                    ? ColorApp.primaryColor
                    : ColorApp.borderColor,
            colorText:
                taxiController.selectedTaxiAddress.value == null
                    ? ColorApp.subColor
                    : ColorApp.whiteColor,
          ),
        ),
      ),
    );
  }
}
