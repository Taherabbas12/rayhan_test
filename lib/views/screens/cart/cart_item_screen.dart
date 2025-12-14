// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/views/widgets/message_snak.dart';
import '../../../controllers/cart_item_controller.dart';
import '../../../controllers/storage_controller.dart';
import '../../../data/models/cart_item.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/style_app.dart';
import '../../../utils/constants/values_constant.dart';
import '../../widgets/actions_button.dart';
import 'request_rayhan.dart';
import 'service_rayhan.dart';

class CartItemScreen extends StatefulWidget {
  const CartItemScreen({super.key});

  @override
  State<CartItemScreen> createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final cartItemController = Get.find<CartItemController>();

  @override
  void initState() {
    super.initState();

    // 🔹 إنشاء TabController يدويًا بدل DefaultTabController
    tabController = TabController(length: 2, vsync: this);

    // 🔹 إضافة listener عند تغيّر التبويب
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        if (tabController.index == 0) {
          cartItemController.onOpenScreenCart();
        } else if (tabController.index == 1) {
          cartItemController.onOpenScreenCartService();
        }
      }
    });

    // تشغيل تهيئة السلة
    cartItemController.onOpenScreenCart();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('السلة'), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // buildTaxiTabs(),
            const SizedBox(height: 10),
            Expanded(
              child:
                  //  TabBarView(
                  //   controller: tabController,
                  //   children: [
                  RequestRayhan(),
              //  ServiceRayhan()],
              // ),
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
                    final loggedIn = StorageController.checkLoginStatus();
                    if (!loggedIn) {
                      MessageSnak.message(
                        'يرجى تسجيل الدخول للمتابعة',
                        color: Colors.red,
                      );
                      return;
                    }

                    if (cartItemController.total > 0) {
                      if (cartItemController.currentCartType ==
                          CartType.service) {
                        print('-----A---');

                        // orderScreenService
                        // orderFormScreen
                        Get.toNamed(AppRoutes.orderFormScreen);
                      } else {
                        Get.toNamed(AppRoutes.orderScreen);
                      }
                    }
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
          controller: tabController, // ✅ نربط الكنترولر هنا
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
          tabs: const [Tab(text: 'طلبات ريحان'), Tab(text: 'خدمات ريحان')],
        ),
      ],
    );
  }
}
