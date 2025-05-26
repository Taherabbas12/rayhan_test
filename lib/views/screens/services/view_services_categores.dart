// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';

import '../../../controllers/services_controller.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/values_constant.dart';

class ViewListCategores extends StatelessWidget {
  ViewListCategores({super.key});
  ServicesController restaurantCategoryController =
      Get.find<ServicesController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Values.width,
      height: 35,
      margin: EdgeInsets.only(
        top: Values.circle,
        left: Values.spacerV,

        right: Values.spacerV,
      ),

      // decoration: BoxDecoration(color: ColorApp.greenColor),
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder:
              (context, index) => viewCategory(
                restaurantCategoryController.servicesCategories[index],
              ),
          itemCount: restaurantCategoryController.servicesCategories.length,
        ),
      ),
    );
  }

  Widget viewCategory(var category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Values.circle * .2),

      child: InkWell(
        borderRadius: BorderRadius.circular(Values.spacerV),
        onTap: () {
          // Select Category

          restaurantCategoryController.selectSection(category);
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
                  restaurantCategoryController.servicesCategorie.value == null
                      ? Colors.transparent
                      : restaurantCategoryController.servicesCategorie.value ==
                          category
                      ? ColorApp.primaryColor
                      : Colors.transparent,
              border: Border.all(
                width: .5,
                color:
                    restaurantCategoryController.servicesCategorie.value == null
                        ? ColorApp.backgroundColorContent
                        : restaurantCategoryController
                                .servicesCategorie
                                .value ==
                            category
                        ? ColorApp.primaryColor
                        : ColorApp.backgroundColorContent,
              ),
              borderRadius: BorderRadius.circular(Values.spacerV),
            ),
            child: Text(
              category.name,
              style: StringStyle.textLabil.copyWith(
                color:
                    restaurantCategoryController.servicesCategorie.value == null
                        ? ColorApp.backgroundColorContent
                        : restaurantCategoryController
                                .servicesCategorie
                                .value ==
                            category
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
