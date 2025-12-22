// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/color_app.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import 'package:rayhan_test/views/widgets/common/loading_indicator.dart';

import '../../../../controllers/market_controller.dart';
import '../../../../controllers/market_product_controller.dart';
import '../../../../data/models/cart_item.dart';
import '../../../../utils/constants/values_constant.dart';
import '../../../widgets/more_widgets.dart';
import 'product_widget_grid.dart';
import 'view_market_sub_categorey.dart';

class CategoryDetailsScreen extends StatelessWidget {
  CategoryDetailsScreen({super.key});
  MarketProductController marketProductController =
      Get.find<MarketProductController>();
  MarketController marketController = Get.find<MarketController>();

  @override
  Widget build(BuildContext context) {
    marketProductController.fetchSubCategores(
      marketController.selectCategories.value!.id,
    );

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            marketController.selectCategories.value == null
                ? 'الفئة الفرعية'
                : marketController.selectCategories.value!.name,
            style: StringStyle.textLabil,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            color: ColorApp.backgroundColor,
            padding: EdgeInsets.only(
              left: Values.spacerV,
              right: Values.spacerV,
              bottom: Values.spacerV,
            ),
            child: ViewMarketSubCategorey(),
          ),
          Expanded(
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ), // المسافة من اليمين واليسار فقط
                child:
                    marketProductController.isLoadingProduct.value
                        ? SizedBox(height: 300, child: LoadingIndicator())
                        : marketProductController.productsMarket.isEmpty
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
                                    marketProductController.countView().value,

                                // crossAxisCount:
                                //     marketProductController.countView().value,

                                // crossAxisSpacing: 10,
                                shrinkWrap: true,
                                crossAxisSpacing: 10,

                                itemBuilder:
                                    (context, index) => ProductWidgetGrid(
                                      product:
                                          marketProductController
                                              .productsMarket[index],
                                    ),
                                itemCount:
                                    marketProductController
                                        .productsMarket
                                        .length,
                              ),
                            );
                          },
                        ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: cartShowInScreenTotal(CartType.mart),
    );
  }

  // shopController
}
