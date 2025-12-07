import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/market_controller.dart';
import '../../../../controllers/restaurant_controller.dart';
import '../../../../controllers/shops_controller.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/style_app.dart';
import 'rayhan_search/list_rayhan_search.dart';
import 'restaurant_search/list_restaurent_search.dart';
import 'shop_search/list_shop_search.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final TextEditingController searchController = TextEditingController();
  final MarketController marketController = Get.find<MarketController>();
  final ShopsController shopController = Get.find<ShopsController>();
  final RestaurantController restaurantController =
      Get.find<RestaurantController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          // رأس الصفحة
          AppBar(title: const Text('البحث')),

          // حقل البحث
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: ColorApp.borderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CupertinoSearchTextField(
              backgroundColor: ColorApp.whiteColor,
              placeholder: 'إبحث عن المنتج الذي تريده',
              controller: searchController,
              autocorrect: true,
              style: StringStyle.textLabil.copyWith(
                color: ColorApp.textPrimaryColor,
                fontWeight: FontWeight.w300,
              ),
              placeholderStyle: StringStyle.textLabil.copyWith(
                color: ColorApp.subColor,
                fontWeight: FontWeight.w300,
              ),
              onChanged: (value) {
                marketController.fetchShopProductsSearch(value);
                shopController.fetchRestaurantSearch(value);
                restaurantController.fetchRestaurantSearch(value);
              },
            ),
          ),

          const SizedBox(height: 12),

          // التابات مع خط سفلي كامل
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: ColorApp.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ColorApp.borderColor),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: ColorApp.borderColor),
                    ),
                  ),
                  child: TabBar(
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    isScrollable: false,

                    // توزيع جميع التابات بالتساوي
                    tabs: [
                      Tab(text: 'المتاجر'),
                      Tab(text: 'الطعام'),
                      Tab(text: 'الماركت'),
                    ],

                    // لون التاب المحدد
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.tab,
                    // الخط السفلي للتاب المحدد
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFF005BBB), width: 3),
                      ),
                    ),
                  ),
                ),

                // خط سفلي على طول التابات بالكامل
                // Container(
                //   width: double.infinity,
                //   height: 2,
                //   color: ColorApp.borderColor,
                // ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: TabBarView(
              children: [
                ListRayhanSearch(),
                ListRestaurentSearch(),
                ListShopSearch(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
