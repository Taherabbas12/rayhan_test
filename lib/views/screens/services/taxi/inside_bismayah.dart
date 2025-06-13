import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';

import '../../../../controllers/taxi_controller.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';
import 'recent_address.dart';

class InsideBismayah extends StatelessWidget {
  InsideBismayah({super.key});
  final TaxiController taxiController = Get.find<TaxiController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isStart = !taxiController.isCompleteStartingPoint.value;
      return Column(
        children: [
          Row(
            children: [
              SizedBox(width: Values.circle * 2.4),
              inputDropDown(
                hintText: 'اختر البلوك',
                labelText: isStart ? 'الانطلاق - البلوك' : 'الوصول - البلوك',
                items:
                    taxiController.taxiAddresses
                        .map(
                          (e) =>
                              DropdownMenuItem(value: e, child: Text(e.name)),
                        )
                        .toList(),
                initialValue:
                    isStart
                        ? taxiController.selectedTaxi.value
                        : taxiController.selectedTaxi2.value,
                onChanged: (value) {
                  if (isStart) {
                    taxiController.selectTaxi(value as Taxi);
                  } else {
                    taxiController.selectTaxi2(value as Taxi);
                  }
                },
              ),
              SizedBox(width: Values.circle * 2),
              Obx(() {
                final selectedTaxi =
                    isStart
                        ? taxiController.selectedTaxi.value
                        : taxiController.selectedTaxi2.value;
                final selectedAddress =
                    isStart
                        ? taxiController.selectedTaxiAddress.value
                        : taxiController.selectedTaxiAddress2.value;
                return selectedTaxi == null
                    ? Expanded(child: SizedBox())
                    : inputDropDown(
                      hintText: 'اختر البناية',
                      labelText:
                          isStart ? 'الانطلاق - البناية' : 'الوصول - البناية',
                      items:
                          selectedTaxi.addresses
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                      initialValue: selectedAddress,
                      onChanged: (value) {
                        if (isStart) {
                          taxiController.selectTaxiAddress(value as String);
                        } else {
                          taxiController.selectTaxiAddress2(value as String);
                        }
                      },
                    );
              }),
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
        ],
      );
    });
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
}
