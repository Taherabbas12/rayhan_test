import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/style_app.dart';
import '../../../utils/constants/values_constant.dart';
import '../actions_button.dart';

class ShowModalBottomSheetC {
  static void showCupertinoBottomSheet({
    required List<Object> data,
    required String title,
    required Function(String name) onTap,
  }) {
    showCupertinoModalPopup(
      context: Get.context!,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoActionSheet(
          title: Text(title, style: StringStyle.headerStyle),
          actions:
              data
                  .map(
                    (item) => CupertinoActionSheetAction(
                      onPressed: () {
                        onTap(item.toString());
                        Get.back();
                      },
                      child: Text(
                        item.toString(),
                        style: StringStyle.headerStyle.copyWith(
                          color: ColorApp.primaryColor,
                        ),
                      ),
                    ),
                  )
                  .toList(),
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text("إلغاء"),
          ),
        );
      },
    );
  }

  static void showBottomSheet2({required Widget data, required String title}) {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: Values.spacerV),
            Text(title, style: StringStyle.headLineStyle2),
            SizedBox(height: Values.spacerV * 2),
            data,
            SizedBox(height: Values.spacerV * 2),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Values.spacerV),
                child: BottonsC.action2(
                  h: 40,
                  color: ColorApp.backgroundColorContent,
                  "إلغاء",
                  () => Get.back(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
