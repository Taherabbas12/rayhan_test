// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import 'package:rayhan_test/views/widgets/common/loading_indicator.dart';

import '../../../../controllers/restaurant_controller.dart';
import '../../../../controllers/shop_controller.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';
import '../../../widgets/actions_button.dart';
import '../../../widgets/more_widgets.dart';
import 'product_widget_grid.dart';
import 'view_shop_categorey.dart';

class ShopScreen extends StatelessWidget {
  ShopScreen({super.key});
  final RestaurantController restaurantController =
      Get.find<RestaurantController>();
  ShopController shopController = Get.find<ShopController>();
  @override
  Widget build(BuildContext context) {
    final restaurant = restaurantController.restaurantSelect.value!;
    shopController.fetchShopCategores(id: restaurant.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Center(
                child: BottonsC.actionIconWithOutColor(
                  size: 25,
                  circle: 50,
                  Icons.arrow_back,
                  'رجوع',
                  color: const Color.fromARGB(255, 7, 44, 30),
                  Get.back,
                ),
              ),
            ),
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                // حساب نسبة التمرير
                double top = constraints.biggest.height;
                double percent = ((top - kToolbarHeight) /
                        (250 - kToolbarHeight))
                    .clamp(0.0, 1.0);

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(left: 56, bottom: 16),
                      title: Text(
                        restaurant.name,
                        style: TextStyle(
                          color: Colors.black.withAlpha(
                            percent < 0.3 ? 250 : 0,
                          ),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      background: imageCached(restaurant.cover, top: true),
                    ),

                    // شعار المطعم

                    // 🆕 الكارد
                    Positioned(
                      bottom: -55,
                      left: 16,
                      right: 16,
                      child: Opacity(
                        opacity: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorApp.backgroundColor,
                            borderRadius: BorderRadius.circular(Values.circle),
                            border: Border.all(
                              color: ColorApp.borderColor,
                              width: .5,
                            ),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  padding: EdgeInsets.all(Values.circle),
                                  decoration: BoxDecoration(
                                    color: ColorApp.backgroundColor,
                                    borderRadius: BorderRadius.circular(
                                      Values.circle,
                                    ),
                                    border: Border.all(
                                      color: ColorApp.borderColor,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: imageCached(
                                    restaurant.logo,
                                    top: true,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        restaurant.name,
                                        style: StringStyle.titleApp,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                top: 60,

                left: Values.spacerV,
                right: Values.spacerV,
              ),
              child: ViewShopCategorey(),
            ),
          ),
          // محتوى الشاشة
          Obx(
            () => SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ), // المسافة من اليمين واليسار فقط
              sliver:
                  shopController.isLoadingProduct.value
                      ? SliverToBoxAdapter(
                        child: SizedBox(height: 300, child: LoadingIndicator()),
                      )
                      : SliverToBoxAdapter(
                        child:
                            shopController.productsShop.isEmpty
                                ? Center(
                                  child: Text(
                                    'لا توجد منتجات',
                                    style: StringStyle.textLabil,
                                  ),
                                )
                                : OrientationBuilder(
                                  builder: (context, orientation) {
                                    return MasonryGridView.count(
                                      crossAxisCount:
                                          shopController.countView().value,

                                      crossAxisSpacing: 10,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (context, index) => ProductWidgetGrid(
                                            product:
                                                shopController
                                                    .productsShop[index],
                                          ),
                                      itemCount:
                                          shopController.productsShop.length,
                                    );
                                  },
                                ),
                      ),
            ),
          ),

          //  SliverGrid.builder(
          //   gridDelegate:
          //       const SliverGridDelegateWithMaxCrossAxisExtent(
          //         maxCrossAxisExtent: 300, // العرض الثابت لكل عنصر
          //         mainAxisSpacing: 8,
          //         crossAxisSpacing: 8,
          //         childAspectRatio: 0.6,
          //       ),

          //   itemBuilder: (context, index) {
          //     return ProductWidgetGrid(
          //       product: shopController.productsShop[index],
          //     );
          //   },
          //   itemCount: shopController.productsShop.length,
          // ),
          // ),
          SliverToBoxAdapter(child: SizedBox(height: Values.spacerV * 2)),
        ],
      ),
    );
  }

  // shopController
}
