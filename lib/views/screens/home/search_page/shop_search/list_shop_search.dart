// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../../controllers/shops_controller.dart';
import '../../../../../data/models/restaurant.dart';
import '../../../../../utils/constants/color_app.dart';
import '../../../../../utils/constants/shadow_values.dart';
import '../../../../../utils/constants/style_app.dart';
import '../../../../../utils/constants/values_constant.dart';
import '../../../../widgets/more_widgets.dart';

class ListShopSearch extends StatelessWidget {
  ListShopSearch({super.key});
  ShopsController restaurantController = Get.find<ShopsController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Values.spacerV),
      child: OrientationBuilder(
        builder: (context, orientation) {
          return Obx(
            () => MasonryGridView.count(
              crossAxisCount: restaurantController.countView().value,
              physics: PageScrollPhysics(),
              crossAxisSpacing: 10,
              shrinkWrap: true,

              itemBuilder:
                  (context, index) => viewRetaurant(
                    restaurantController.restaurantsSearch[index],
                  ),
              itemCount: restaurantController.restaurantsSearch.length,
            ),
          );
        },
      ),
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
