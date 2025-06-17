// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import '../../../../controllers/restaurant_controller.dart';
import '../../../../controllers/shop_controller.dart';
import '../../../../data/models/shop_category.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';
import '../../../widgets/actions_button.dart';
 
class ViewShopCategorey extends StatelessWidget {
  ViewShopCategorey({super.key});
  ShopController shopController = Get.find<ShopController>();
  RestaurantController restaurantController = Get.find<RestaurantController>();
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
          //
          Wrap(
            // alignment: WrapAlignment.center,
            children: [
              viewDetail(
                restaurantController.restaurantSelect.value!.address,
                Icons.location_on,
              ),
              if (restaurantController.restaurantSelect.value!.discount > 0)
                viewDetail(
                  'خصم ${restaurantController.restaurantSelect.value!.discount.toInt()}%',

                  FontAwesomeIcons.percent,
                  iconSize: 16,
                ),
              if (restaurantController.restaurantSelect.value!.freeDelivery)
                viewDetail(
                  'توصيل مجاني',
                  FontAwesomeIcons.carRear,
                  iconSize: 16,
                ),
            ],
          ),
          SizedBox(height: Values.spacerV),
          Row(
            children: [
              Text('الأصناف', style: StringStyle.titleApp),
              Spacer(),
              Obx(
                () => BottonsC.actionIconWithOutColor(
                  Icons.view_agenda_outlined,
                  colorBackgraond:
                      !shopController.isGridView.value
                          ? ColorApp.primaryColor
                          : Colors.transparent,
                  color:
                      !shopController.isGridView.value
                          ? ColorApp.whiteColor
                          : ColorApp.textSecondryColor,
                  'عرض قائمة',
                  () {
                    shopController.isGridView.value = false;
                  },

                  circle: 50,
                  size: 18,
                ),
              ),
              SizedBox(width: Values.circle),

              Obx(
                () => BottonsC.actionIconWithOutColor(
                  Icons.grid_view_outlined,
                  colorBackgraond:
                      shopController.isGridView.value
                          ? ColorApp.primaryColor
                          : Colors.transparent,
                  color:
                      shopController.isGridView.value
                          ? ColorApp.whiteColor
                          : ColorApp.textSecondryColor,
                  'عرض شبكة',
                  () {
                    shopController.isGridView.value = true;
                  },
                  circle: 50,
                  size: 18,
                ),
              ),
            ],
          ),
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

  Widget viewDetail(String value, IconData icon, {double? iconSize}) {
    return Container(
      height: 28,
      padding: EdgeInsets.symmetric(
        horizontal: Values.spacerV,
        vertical: Values.circle * .5,
      ),
      margin: EdgeInsets.all(Values.circle * .5),
      decoration: BoxDecoration(
        color: ColorApp.borderColor.withAlpha(100),
        borderRadius: BorderRadius.circular(Values.circle),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: iconSize ?? Values.spacerV * 1.5),
          SizedBox(width: Values.circle * .5),
          Text(value, style: StringStyle.textLabil),
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
