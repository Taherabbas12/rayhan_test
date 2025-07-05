// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/shadow_values.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import 'package:rayhan_test/views/widgets/common/loading_indicator.dart';

import '../../../controllers/shops_controller.dart';
import '../../../data/models/restaurant.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/values_constant.dart';
import '../../widgets/image_slder.dart';
import '../../widgets/more_widgets.dart';

class ShopLists extends StatelessWidget {
  ShopLists({super.key});
  ShopsController restaurantController = Get.find<ShopsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: Values.spacerV),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Values.spacerV * 1.5),
          child: Text('المتاجر المقترحة', style: StringStyle.titleApp),
        ),
        SizedBox(height: Values.spacerV),
        // Container(
        //   padding: EdgeInsets.only(right: Values.spacerV * 1.5),
        //   height: 40,
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,

        //     itemBuilder:
        //         (context, index) =>
        //             viewFilterOption(RestaurantController.filterOptions[index]),
        //     itemCount: RestaurantController.filterOptions.length,
        //   ),
        // ),
        Obx(
          () =>
              restaurantController.isLoadingRestaurant.value
                  ? SizedBox(height: 300, child: LoadingIndicator())
                  : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Values.spacerV * 1.5,
                    ),
                    child:
                        restaurantController.restaurants.isEmpty
                            ? SizedBox(
                              height: 300,
                              child: Center(
                                child: Text(
                                  'لا توجد مطاعم متاحة في الفئة المحددة',
                                  style: StringStyle.textLabilBold.copyWith(
                                    color: ColorApp.textSecondryColor,
                                  ),
                                ),
                              ),
                            )
                            : OrientationBuilder(
                              builder: (context, orientation) {
                                return MasonryGridView.count(
                                  crossAxisCount:
                                      restaurantController.countView().value,
                                  physics: PageScrollPhysics(),
                                  crossAxisSpacing: 10,
                                  shrinkWrap: true,

                                  itemBuilder:
                                      (context, index) => viewRetaurant(
                                        restaurantController.restaurants[index],
                                      ),
                                  itemCount:
                                      restaurantController.restaurants.length,
                                );
                              },
                            ),
                  ),
        ),
      ],
    );
  }

  Widget viewRetaurant(Restaurant restaurant) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Values.circle),
      child: InkWell(
        borderRadius: BorderRadius.circular(Values.circle),

        onTap: () => restaurantController.selectRestorent(restaurant),
        child: Container(
          margin: EdgeInsets.all(1),
          padding: EdgeInsets.only(bottom: Values.circle),
          decoration: BoxDecoration(
            boxShadow: ShadowValues.shadowValuesBlur,
            color: ColorApp.backgroundColor,
            borderRadius: BorderRadius.circular(Values.circle),
            border: Border.all(color: ColorApp.borderColor), // إطار أبيض
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                clipBehavior:
                    Clip.none, // يسمح بخروج الصورة الصغيرة عن حدود Stack
                children: [
                  SizedBox(
                    height: 170,
                    width: double.infinity, // لو حابب تمتد بعرض الشاشة
                    child: imageCached(restaurant.cover, top: true),
                  ),
                  Positioned(
                    bottom: -30, // ينزل الصورة 30 بكسل خارج الصورة الرئيسية
                    left: 10, // مسافة من اليسار
                    child: Container(
                      width: 70,
                      height: 70,
                      padding: EdgeInsets.all(Values.circle),
                      decoration: BoxDecoration(
                        color: ColorApp.backgroundColor,
                        borderRadius: BorderRadius.circular(Values.circle),
                        border: Border.all(
                          color: ColorApp.borderColor,
                        ), // إطار أبيض
                      ),
                      child: imageCached(restaurant.logo, top: true),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Values.circle),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Values.circle),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      restaurant.name,
                      style: StringStyle.headerStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: Values.circle * .5),
                    Text(
                      restaurant.subName,
                      style: StringStyle.textTable.copyWith(
                        color: ColorApp.textSecondryColor,
                      ),
                    ),
                    SizedBox(height: Values.circle),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        if (restaurant.starAvg > 0)
                          viewE(
                            CupertinoIcons.star_fill,
                            restaurant.starAvg.toString(),
                          ),
                        if (restaurant.discount > 0)
                          viewE(
                            FontAwesomeIcons.percent,
                            'خصم ${restaurant.discount} %',
                          ),
                        if (restaurant.freeDelivery)
                          viewE(FontAwesomeIcons.carRear, 'توصيل مجاني'),
                        viewE(
                          Icons.store_mall_directory_rounded,
                          'حتى ${restaurant.closeTime}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget viewFilterOption(FilterOption category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Values.circle * .2),

      child: InkWell(
        borderRadius: BorderRadius.circular(Values.spacerV),
        onTap: () {
          // Select Category

          restaurantController.selectFilter(category);
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
              // boxShadow: ShadowValues.shadowValuesBlur,
              color:
                  restaurantController.selectFilterOption.value == category
                      ? ColorApp.primaryColor
                      : ColorApp.backgroundColor,
              border: Border.all(
                width: .5,
                color:
                    restaurantController.selectFilterOption.value == category
                        ? ColorApp.primaryColor
                        : ColorApp.borderColor,
              ),
              borderRadius: BorderRadius.circular(Values.spacerV),
            ),
            child: Text(
              category.label,
              style: StringStyle.textLabil.copyWith(
                color:
                    restaurantController.selectFilterOption.value == category
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

Widget viewE(IconData icon, String value) {
  return Row(
    children: [
      Icon(icon, color: ColorApp.primaryColor, size: 17),
      SizedBox(width: Values.circle * .5),
      Text(value, style: StringStyle.textLabilBold),
      SizedBox(width: Values.circle * .5),
    ],
  );
}
