// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/cart_item_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/style_app.dart';
import '../../../utils/constants/values_constant.dart';
import '../../widgets/actions_button.dart';
import 'request_rayhan.dart';

class CartItemScreen extends StatelessWidget {
  CartItemScreen({super.key});
  CartItemController cartItemController = Get.find<CartItemController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: const Text('السلة'), centerTitle: true),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              buildTaxiTabs(), // TabBar بدون أيقونات
              const SizedBox(height: 10),

              Expanded(
                child: TabBarView(children: [RequestRayhan(), RequestRayhan()]),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          padding: EdgeInsets.symmetric(vertical: Values.circle),
          decoration: BoxDecoration(
            color: ColorApp.backgroundColor,
            border: Border.all(color: ColorApp.borderColor.withAlpha(50)),
          ),
          child: Row(
            children: [
              SizedBox(width: Values.spacerV),

              SizedBox(
                width: Values.width * .3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        '(${cartItemController.countProduct}) عناصر',
                        style: StringStyle.textLabil.copyWith(
                          color: ColorApp.textSecondryColor,
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        '${cartItemController.total.toStringAsFixed(0)} د.ع',
                        style: StringStyle.textLabil,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Obx(
                  () => BottonsC.action1(
                    h: 50,
                    'التالي',
                    () {
                      if (cartItemController.total > 0) {
                        Get.toNamed(AppRoutes.orderScreen);
                      }
                      // restaurantController.addToCart(
                      //   product,
                      //   noteController.text,
                      //   quantity,
                      // );
                    },
                    color:
                        cartItemController.total > 0
                            ? ColorApp.primaryColor
                            : ColorApp.subColor,
                  ),
                ),
              ),
              SizedBox(width: Values.spacerV),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTaxiTabs() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: -1,
          child: Divider(color: ColorApp.borderColor, height: 0, thickness: 2),
        ),
        TabBar(
          indicator: UnderlineTabIndicator(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Values.spacerV * 5),
              topRight: Radius.circular(Values.spacerV * 5),
            ),
            borderSide: BorderSide(width: 4, color: ColorApp.primaryColor),
          ),
          dividerColor: ColorApp.borderColor,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.symmetric(
            horizontal: Values.spacerV * 2,
          ),
          labelColor: ColorApp.primaryColor,
          unselectedLabelColor: Colors.black,
          indicatorColor: ColorApp.primaryColor,
          labelStyle: StringStyle.headerStyle,
          unselectedLabelStyle: StringStyle.headerStyle.copyWith(
            color: ColorApp.subColor,
            fontSize: 16,
          ),

          indicatorAnimation: TabIndicatorAnimation.elastic,
          splashBorderRadius: BorderRadius.circular(Values.circle),
          tabs: [Tab(text: 'طلبات ريحان'), Tab(text: 'خدمات ريحان')],
        ),
      ],
    );
  }
}
