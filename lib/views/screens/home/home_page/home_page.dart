// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../controllers/home_get_all_controller.dart';
import '../../../../controllers/restaurant_controller.dart' hide FilterOption;
import '../../../../controllers/shops_controller.dart';
import '../../../../data/models/restaurant.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/style_app.dart';
import '../../../../utils/constants/values_constant.dart';
import '../../../widgets/image_slder.dart';
import '../../../widgets/more_widgets.dart';
import 'header_home.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController homeController = Get.find<HomeController>();
  final RestaurantController restaurantController =
      Get.find<RestaurantController>();
  final HomeGetAllController homeGetAllController =
      Get.find<HomeGetAllController>();
  ShopsController shopsController = Get.find<ShopsController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          HeaderHome(),
          SizedBox(height: Values.spacerV * 2),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Values.spacerV),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  homeController.widgetHomes.map((e) => homeView(e)).toList(),
            ),
          ),
          SizedBox(height: Values.spacerV * 2),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Values.circle * 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الرائج الان',
                  style: StringStyle.titleApp.copyWith(fontSize: 20),
                ),
                Text(
                  'عرض الكل',
                  style: StringStyle.textLabil.copyWith(
                    color: ColorApp.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Values.spacerV * 2),

          Obx(
            () =>
                homeGetAllController.forNowShop.isEmpty
                    ? SizedBox()
                    : SizedBox(
                      height: 265,

                      width: Values.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,

                        itemBuilder:
                            (context, index) =>
                                index == 0
                                    ? SizedBox(width: 20)
                                    : viewRetaurant(
                                      homeGetAllController.forNowShop[index -
                                          1],
                                    ),
                        itemCount: homeGetAllController.forNowShop.length + 1,
                      ),
                    ),
          ),
          SizedBox(height: Values.circle * .7),
          Obx(
            () =>
                homeGetAllController.sliderImageModel.isEmpty
                    ? SizedBox()
                    : ImageSlider(
                      // h: Values.width * .4,
                      imageList: homeGetAllController.sliderImageModel,
                    ),
          ),

          // الرائج الان

          //
        ],
      ),
    );
  }

  Widget homeView(WidgetHome home) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(Values.circle * .5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(Values.spacerV),
              splashColor: ColorApp.iconHomeColor,
              onTap: home.toPage,
              child: Container(
                margin: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: ColorApp.iconHomeColor,
                  border: Border.all(color: ColorApp.borderColor),
                  borderRadius: BorderRadius.circular(Values.spacerV),
                ),

                height: Values.width * .23,

                child: Image.asset(home.image),
              ),
            ),
            Text(
              home.name,
              style: StringStyle.headerStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget viewRetaurant(Restaurant restaurant) {
    return SizedBox(
      width: 174, // عرض البطاقة
      child: Padding(
        // color: ColorApp.greenColor,
        padding: EdgeInsets.all(Values.circle * .2),
        child: GestureDetector(
          onTap: () => shopsController.selectRestorent(restaurant),
          child: Padding(
            // color: ColorApp.greenColor,
            padding: EdgeInsets.all(Values.circle * .4),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    // الصورة الرئيسية
                    SizedBox(
                      height: 194,

                      child: imageCached(restaurant.cover, circle: 18),
                    ),

                    // اللوقو Positioned
                    Positioned(
                      top: 2,
                      right: 2,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: SizedBox(
                          height: 56,
                          width: 56,
                          child: imageCached(restaurant.logo, circle: 10),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: Values.circle * .5),

                Text(
                  restaurant.name,
                  style: StringStyle.headerStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Values.circle * .7),
                Text(
                  restaurant.subName,
                  style: StringStyle.textTable.copyWith(
                    color: ColorApp.textSecondryColor,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                // SizedBox(height: 8),

                // // ⭐ التقييم
                // Row(
                //   children: [
                //     // عدد التقييمات
                //     Text(
                //       "(${restaurant.id}) ", // فقط مثال — عدل حسب بياناتك
                //       style: TextStyle(color: Colors.grey[600], fontSize: 14),
                //     ),

                //     // التقييم
                //     Text(
                //       "${restaurant.starAvg}",
                //       style: TextStyle(
                //         color: Colors.grey[800],
                //         fontSize: 15,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),

                //     SizedBox(width: 5),

                //     Icon(Icons.star, color: ColorApp.primaryColor, size: 18),
                //   ],
                // ),
              ],
            ),
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

          shopsController.selectFilter(category);
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
