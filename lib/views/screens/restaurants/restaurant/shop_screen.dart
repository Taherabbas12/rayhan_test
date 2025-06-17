// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import 'package:rayhan_test/views/widgets/common/loading_indicator.dart';

import '../../../../controllers/restaurant_controller.dart';
import '../../../../controllers/shop_controller.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';
import '../../../widgets/actions_button.dart';
import '../../../widgets/more_widgets.dart';
import '../retaurant_list.dart';
import 'product_widget_grid.dart';
import 'product_widget_horizontal.dart';
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
            leading: Center(
              child: BottonsC.actionIconWithOutColor(
                size: 30,
                circle: 50,
                Icons.arrow_back_rounded,
                'رجوع',
                color: ColorApp.primaryColor,
                Get.back,
              ),
            ),
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    FlexibleSpaceBar(
                      background: imageCached(restaurant.cover, top: true),
                    ),

                    // شعار المطعم

                    // 🆕 الكارد
                    Positioned(
                      bottom: -55,
                      left: 16,
                      right: 16,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                child: imageCached(restaurant.logo, top: true),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      restaurant.name,
                                      style: StringStyle.titleApp,
                                    ),
                                    Text(
                                      restaurant.subName,
                                      style: StringStyle.textLabilBold,
                                    ),
                                    SizedBox(height: Values.circle),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

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
                                          viewE(
                                            FontAwesomeIcons.carRear,
                                            'توصيل مجاني',
                                          ),
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
                                    return Obx(
                                      () => MasonryGridView.count(
                                        crossAxisCount:
                                            shopController.isGridView.value
                                                ? shopController
                                                    .countView()
                                                    .value
                                                : 1,

                                        crossAxisSpacing: 10,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (context, index) =>
                                                shopController.isGridView.value
                                                    ? ProductWidgetGrid(
                                                      product:
                                                          shopController
                                                              .productsShop[index],
                                                    )
                                                    : ProductWidgetHorizontal(
                                                      product:
                                                          shopController
                                                              .productsShop[index],
                                                    ),
                                        itemCount:
                                            shopController.productsShop.length,
                                      ),
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
