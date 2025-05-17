// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import '../../../../controllers/market_product_controller.dart';
import '../../../../data/models/shop_category.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';

class ViewMarketSubCategorey extends StatelessWidget {
  ViewMarketSubCategorey({super.key});
  MarketProductController marketProductController = Get.find<MarketProductController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Values.width,

      margin: EdgeInsets.only(top: Values.circle),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 36,
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder:
                    (context, index) =>
                        viewCategory(marketProductController.marketSubCategories[index]),
                itemCount: marketProductController.marketSubCategories.length,
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

          marketProductController.selectCategory(category);
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
                  marketProductController.selectSubCategories.value == null
                      ? Colors.transparent
                      : marketProductController.selectSubCategories.value == category
                      ? ColorApp.primaryColor
                      : Colors.transparent,
              border: Border.all(
                width: .5,
                color:
                    marketProductController.selectSubCategories.value == null
                        ? ColorApp.backgroundColorContent
                        : marketProductController.selectSubCategories.value == category
                        ? ColorApp.primaryColor
                        : ColorApp.backgroundColorContent,
              ),
              borderRadius: BorderRadius.circular(Values.spacerV),
            ),
            child: Text(
              category.name,
              style: StringStyle.textLabil.copyWith(
                color:
                    marketProductController.selectSubCategories.value == null
                        ? ColorApp.backgroundColorContent
                        : marketProductController.selectSubCategories.value == category
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
