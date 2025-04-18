// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/shadow_values.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';

import '../../../controllers/restaurant_category_controller.dart';
import '../../../data/models/restaurant_category.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/values_constant.dart';
import '../../widgets/more_widgets.dart';

class ViewListCategores extends StatelessWidget {
  ViewListCategores({super.key});
  RestaurantCategoryController restaurantCategoryController =
      Get.find<RestaurantCategoryController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Values.width,
      height: 105,
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

  Widget viewCategory(RestaurantCategory category) {
    return InkWell(
      onTap: () {
        // Select Category
      },
      child: Container(
        height: 100,
        width: 75,
        // decoration: BoxDecoration(
        //   lor: ColorApp.backgroundColor,
        //   boxShadow: ShadowValues.shadowValues,
        //   borderRadius: BorderRadius.circular(Values.circle),
        // ),
        // decoration: BoxDecoration(color: ColorApp.backgroundColor),
        margin: EdgeInsets.symmetric(horizontal: Values.circle * .5),
        child: Column(
          children: [
            Container(
              height: 75,
              width: 75,
              padding: EdgeInsets.all(Values.circle),

              margin: EdgeInsets.symmetric(horizontal: Values.circle * .2),
              child: imageCached(category.image, circle: 0),
            ),
            Text(category.name, style: StringStyle.textLabil),
          ],
        ),
      ),
    );
  }
}
