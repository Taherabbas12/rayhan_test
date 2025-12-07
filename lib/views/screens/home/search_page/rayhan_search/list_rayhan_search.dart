// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/images_url.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
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
        () =>
            marketController.isLoadingProductSearch.value
                ? LoadingIndicator()
                : marketController.productsSearch.isEmpty
                ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Values.circle * 2.4,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(ImagesUrl.imageFrame, width: 250),
                      SizedBox(height: Values.circle * 4),
                      Text('لا يوجد نتائج', style: StringStyle.titleApp),
                      SizedBox(height: Values.circle),

                      Text(
                        'عذراً، لم يتم العثور على الكلمة الرئيسية التي أدخلتها، يرجى التحقق مرة أخرى أو البحث باستخدام كلمة رئيسية أخرى.',
                        style: StringStyle.textLabil.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                )
                : ListView.builder(
                  itemBuilder:
                      (context, index) => ProductWidgetHorizontalSearch(
                        product: marketController.productsSearch[index],
                      ),
                  itemCount: marketController.productsSearch.length,
                ),
      ),
    );
  }
}
