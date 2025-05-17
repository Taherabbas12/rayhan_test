// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';

import '../../../controllers/market_controller.dart';
import '../../../data/models/category.dart';
import '../../../utils/constants/values_constant.dart';
import '../../widgets/more_widgets.dart';

class MarketListCategores extends StatelessWidget {
  MarketListCategores({super.key});
  MarketController marketController = Get.find<MarketController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Values.width,

      // color: ColorApp.backgroundColorContent,
      margin: EdgeInsets.only(
        top: Values.circle,
        left: Values.circle,
        right: Values.circle,
      ),

      // decoration: BoxDecoration(color: ColorApp.greenColor),
      child: OrientationBuilder(
        builder: (context, orientation) {
          return Obx(
            () => MasonryGridView.count(
              crossAxisCount: marketController.countView().value,
              mainAxisSpacing: 10,

              physics: PageScrollPhysics(),

              // crossAxisSpacing: 10,
              shrinkWrap: true,

              itemBuilder:
                  (context, index) => viewCategory(
                    marketController.marketCategories[index],
                    marketController,
                  ),
              itemCount: marketController.marketCategories.length,
            ),
          );
        },
      ),
    );
  }
}

Widget viewCategory(Category category, MarketController marketController) {
  return Padding(
    padding: EdgeInsets.all(Values.circle * .2),
    child: InkWell(
      borderRadius: BorderRadius.circular(Values.circle),

      onTap: () {
        // Select Category

        marketController.selectCategory(category);
      },
      child: Container(
        decoration: BoxDecoration(
          // color: ColorApp.backgroundColor,
          // color:
          //     restaurantCategoryController.selectCategories.value == null
          //         ? Colors.transparent
          //         : restaurantCategoryController.selectCategories.value ==
          //             category
          //         ? ColorApp.primaryColor
          //         : Colors.transparent,
          // border: Border.all(
          //   width: 1,
          //   color:
          //       marketController.selectCategories.value == null
          //           ? Colors.transparent
          //           : marketController.selectCategories.value == category
          //           ? ColorApp.primaryColor
          //           : Colors.transparent,
          // ),
          // boxShadow: ShadowValues.shadowValues,
          borderRadius: BorderRadius.circular(Values.circle),
        ),
        // decoration: BoxDecoration(color: ColorApp.backgroundColor),
        // margin: EdgeInsets.symmetric(horizontal: Values.circle * .5),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(Values.circle * .5),

              child: imageCached(
                category.image,
                circle: 5,
                down: true,
                top: true,
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
  );
}
