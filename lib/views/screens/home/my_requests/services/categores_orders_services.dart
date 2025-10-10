import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/my_request_services_controller.dart';
import '../../../../../utils/constants/color_app.dart';
import '../../../../../utils/constants/style_app.dart';
import '../../../../../utils/constants/values_constant.dart';

class CategoresOrdersServices extends StatelessWidget {
  CategoresOrdersServices({super.key});
  final MyRequestServicesController myRequestController =
      Get.find<MyRequestServicesController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Values.circle * 2.4),
      decoration: BoxDecoration(
        color: ColorApp.borderColor.withAlpha(50),
        borderRadius: BorderRadius.circular(Values.circle),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          recent(MyRequestServicesController.orderTypes[0]),
          recent(MyRequestServicesController.orderTypes[1]),
        ],
      ),
    );
  }

  Widget recent(OrderStatues title) {
    return Expanded(
      child: InkWell(
        onTap: () => myRequestController.changeType(title),
        child: Obx(
          () => Container(
            alignment: Alignment.center,
            height: 35,
            decoration: BoxDecoration(
              color:
                  myRequestController.selectType.value == title
                      ? ColorApp.primaryColor
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(Values.circle),
            ),
            child: Text(
              title.name,
              style: StringStyle.textLabil.copyWith(
                color:
                    myRequestController.selectType.value != title
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
