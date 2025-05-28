import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/home_controller.dart';
import '../../../../controllers/restaurant_controller.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/style_app.dart';
import '../../../../utils/constants/values_constant.dart';
import '../../../widgets/image_slder.dart';
import 'header_home.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController homeController = Get.find<HomeController>();
  final RestaurantController restaurantController =
      Get.find<RestaurantController>();

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

          Obx(
            () =>
                restaurantController.sliderImageModel.isEmpty
                    ? SizedBox()
                    : ImageSlider(
                      imageList: restaurantController.sliderImageModel,
                    ),
          ),
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
}
