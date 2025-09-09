// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/views/widgets/common/loading_indicator.dart';

import '../../../../../controllers/market_controller.dart';
import '../../../../../utils/constants/values_constant.dart';
import 'product_widget_horizontal_search.dart';

class ListRayhanSearch extends StatelessWidget {
  ListRayhanSearch({super.key});
  MarketController marketController = Get.find<MarketController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Values.spacerV),
      child: Obx(
        () => ListView.builder(
          itemBuilder:
              (context, index) =>
                  marketController.isLoadingProductSearch.value
                      ? LoadingIndicator()
                      : ProductWidgetHorizontalSearch(
                        product: marketController.productsSearch[index],
                      ),
          itemCount: marketController.productsSearch.length,
        ),
      ),
    );
  }
}
