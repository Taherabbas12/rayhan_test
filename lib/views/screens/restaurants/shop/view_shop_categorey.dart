// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import '../../../../controllers/shop_controller.dart';
import '../../../../data/models/shop_category.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';

class ViewShopCategorey extends StatelessWidget {
  ViewShopCategorey({super.key});
  ShopController shopController = Get.find<ShopController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Values.width,

      margin: EdgeInsets.only(top: Values.circle),

      // decoration: BoxDecoration(color: ColorApp.greenColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('الأصناف', style: StringStyle.titleApp),
          SizedBox(height: Values.circle),
          SizedBox(
            height: 36,
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder:
                    (context, index) =>
                        viewCategory(shopController.shopCategores[index]),
                itemCount: shopController.shopCategores.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget viewCategory(ShopCategory category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Values.circle * .2),

      child: InkWell(
        borderRadius: BorderRadius.circular(Values.spacerV),
        onTap: () {
          // Select Category

          shopController.selectCategory(category);
        },
        child: Obx(
          () => Container(
            margin: EdgeInsets.all(1),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: Values.spacerV,
              vertical: Values.circle * .5,
            ),
            decoration: BoxDecoration(
              color:
                  shopController.shopCategorySelect.value == null
                      ? Colors.transparent
                      : shopController.shopCategorySelect.value == category
                      ? ColorApp.primaryColor
                      : Colors.transparent,
              border: Border.all(
                width: .5,
                color:
                    shopController.shopCategorySelect.value == null
                        ? ColorApp.backgroundColorContent
                        : shopController.shopCategorySelect.value == category
                        ? ColorApp.primaryColor
                        : ColorApp.backgroundColorContent,
              ),
              borderRadius: BorderRadius.circular(Values.spacerV),
            ),
            child: Text(
              category.name,
              style: StringStyle.textLabil.copyWith(
                color:
                    shopController.shopCategorySelect.value == null
                        ? ColorApp.backgroundColorContent
                        : shopController.shopCategorySelect.value == category
                        ? ColorApp.whiteColor
                        : ColorApp.backgroundColorContent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
