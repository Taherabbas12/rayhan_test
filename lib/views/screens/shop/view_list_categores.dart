// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';

import '../../../controllers/shops_controller.dart';
import '../../../data/models/category.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/values_constant.dart';
import '../../widgets/more_widgets.dart';

class ViewListCategores extends StatelessWidget {
  ViewListCategores({super.key});
  ShopsController restaurantCategoryController = Get.find<ShopsController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Values.width,
      height: 105,
      // color: ColorApp.backgroundColorContent,
      margin: EdgeInsets.only(top: Values.circle),

      // decoration: BoxDecoration(color: ColorApp.greenColor),
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder:
              (context, index) => viewCategory(
                restaurantCategoryController.restaurantCategories[index],
              ),
          itemCount: restaurantCategoryController.restaurantCategories.length,
        ),
      ),
    );
  }

  Widget viewCategory(Category category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Values.circle * .5),
      child: InkWell(
        borderRadius: BorderRadius.circular(Values.circle),

        onTap: () {
          // Select Category

          restaurantCategoryController.selectCategory(category);
        },
        child: Obx(
          () => Container(
            height: 100,
            width: 75,
            decoration: BoxDecoration(
              // color: ColorApp.backgroundColor,
              // color:
              //     restaurantCategoryController.selectCategories.value == null
              //         ? Colors.transparent
              //         : restaurantCategoryController.selectCategories.value ==
              //             category
              //         ? ColorApp.primaryColor
              //         : Colors.transparent,
              border: Border.all(
                width: 1,
                color:
                    restaurantCategoryController.selectCategories.value == null
                        ? Colors.transparent
                        : restaurantCategoryController.selectCategories.value ==
                            category
                        ? ColorApp.primaryColor
                        : Colors.transparent,
              ),
              // boxShadow: ShadowValues.shadowValues,
              borderRadius: BorderRadius.circular(Values.circle),
            ),
            // decoration: BoxDecoration(color: ColorApp.backgroundColor),
            // margin: EdgeInsets.symmetric(horizontal: Values.circle * .5),
            child: Column(
              children: [
                Container(
                  height: 75,
                  width: 80,
                  padding: EdgeInsets.all(Values.circle),

                  margin: EdgeInsets.symmetric(horizontal: Values.circle * .2),
                  child: imageCached(
                    category.image,
                    circle: 0,
                    boxFit: BoxFit.fitWidth,
                  ),
                ),
                Text(
                  category.name,
                  style: StringStyle.textLabil.copyWith(
                    // color:
                    //     restaurantCategoryController.selectCategories.value ==
                    //             null
                    //         ? ColorApp.blackColor
                    //         : restaurantCategoryController
                    //                 .selectCategories
                    //                 .value ==
                    //             category
                    //         ? ColorApp.whiteColor
                    //         : ColorApp.blackColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
