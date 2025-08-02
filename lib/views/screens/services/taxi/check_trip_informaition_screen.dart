import 'package:flutter/material.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';

import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';

class CheckTripInformaitionScreen extends StatelessWidget {
  const CheckTripInformaitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تأكد من معلومات الرحلة')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Values.spacerV * 2),
        child: Column(
          children: [
            Text(
              'تأكد من معلومات الانطلاق والتوجه ليتم البحث عن السائق .',
              style: StringStyle.textLabil,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorApp.borderColor),
                borderRadius: BorderRadius.circular(Values.circle),
              ),
              child: Column(
                children: [
                  Text(
                    'معلومات الانطلاق والوصول',
                    style: StringStyle.textButtom.copyWith(
                      color: ColorApp.blackColor,
                    ),
                  ),
                  Divider(color: ColorApp.borderColor),
                  Column(
                    children: [
                      Text(
                        'معلومات الانطلاق والوصول',
                        style: StringStyle.textButtom.copyWith(
                          color: ColorApp.blackColor,
                        ),
                      ),
                      Divider(color: ColorApp.borderColor),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget location
}
