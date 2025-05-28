import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';

import '../../../../controllers/taxi_controller.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';

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
            // inputDropDown(
            //   hintText: 'اختر البناية',
            //   labelText: 'البناية',
            //   items: ['1', '2', '3', '4', '5'],
            //   onChanged: (value) {},
            // ),
            SizedBox(width: Values.circle * 2.4),
          ],
        ),
        SizedBox(height: Values.circle * 2),
        Row(
          children: [
            SizedBox(width: Values.circle * 2.4),
            recent(taxiController.addressType[0]),
            SizedBox(width: Values.circle * 2),
            recent(taxiController.addressType[1]),
            SizedBox(width: Values.circle * 2.4),
          ],
        ),
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
                      : ColorApp.backgroundColor,
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
              textAlign: TextAlign.center
            ),
          ),
        ),
      ),
    );
  }
}
