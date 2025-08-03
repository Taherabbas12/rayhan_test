import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/images_url.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import 'package:rayhan_test/views/widgets/common/svg_show.dart';

import '../../../../controllers/taxi_controller.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';

class CheckTripInformaitionScreen extends StatelessWidget {
  CheckTripInformaitionScreen({super.key});
  final TaxiController taxiController = Get.find<TaxiController>();

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
              style: StringStyle.textLabil.copyWith(
                color: ColorApp.backgroundColorContent,
              ),
            ),
            SizedBox(height: Values.spacerV * 2),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorApp.borderColor),
                borderRadius: BorderRadius.circular(Values.circle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Values.spacerV,
                      vertical: Values.circle,
                    ),
                    child: Text(
                      'معلومات الانطلاق والوصول',
                      style: StringStyle.textButtom.copyWith(
                        color: ColorApp.blackColor,
                      ),
                    ),
                  ),
                  Divider(color: ColorApp.borderColor),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // الجزء الأيسر (الأيقونات + الخط)
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // الخط المتقطع بين الأيقونات
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: VerticalDashedLine(
                                  color: const Color(0xff96c0b0),
                                ),
                              ),
                            ),
                            // الأيقونات داخل Column
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Values.circle),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xffE8F1EE),
                                      width: 8,
                                    ),
                                    color: ColorApp.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: svgImage(
                                    ImagesUrl.startLocationIcon,
                                    color: ColorApp.whiteColor,
                                  ),
                                ),
                                SizedBox(height: Values.spacerV * 1.5),
                                Container(
                                  padding: EdgeInsets.all(Values.circle),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xffE8F1EE),
                                      width: 8,
                                    ),
                                    color: ColorApp.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: svgImage(
                                    ImagesUrl.endLocationIcon,
                                    color: ColorApp.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // الجزء الأيمن (النصوص)
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Values.spacerV,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      taxiController.startingPointFullText,
                                      style: StringStyle.textButtom.copyWith(
                                        color: ColorApp.blackColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: ColorApp.borderColor,
                                  thickness: 1,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      taxiController.endPointFullText,
                                      style: StringStyle.textButtom.copyWith(
                                        color: ColorApp.blackColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                taxiController.submetOrderTaxi();
              },
              child: Container(
                alignment: Alignment.center,
                height: 60,
                decoration: BoxDecoration(
                  color: ColorApp.primaryColor,
                  borderRadius: BorderRadius.circular(Values.spacerV * 2),
                ),
                child: Text(
                  'تأكيد',
                  style: StringStyle.textButtom,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: Values.spacerV * 2),
          ],
        ),
      ),
    );
  }

  Widget location() {
    return Column(
      children: [
        Text(
          'معلومات الانطلاق والوصول',
          style: StringStyle.textButtom.copyWith(color: ColorApp.blackColor),
        ),
      ],
    );
  }
}

class VerticalDashedLine extends StatelessWidget {
  final Color color;

  const VerticalDashedLine({super.key, this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double height = constraints.maxHeight;
        const dashHeight = 4.0;
        final dashCount = (height / (2 * dashHeight)).floor();

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return Container(width: 2, height: dashHeight, color: color);
          }),
        );
      },
    );
  }
}
