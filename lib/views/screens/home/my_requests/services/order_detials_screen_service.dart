// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/views/widgets/common/loading_indicator.dart';
import 'package:rayhan_test/views/widgets/more_widgets.dart';
import '../../../../../controllers/my_request_controller.dart';
import '../../../../../utils/constants/color_app.dart';
import '../../../../../utils/constants/style_app.dart';
import '../../../../../utils/constants/values_constant.dart';

class OrderDetailsScreenServices extends StatelessWidget {
  OrderDetailsScreenServices({super.key});
  MyRequestController myRequestController = Get.find<MyRequestController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('منتجات الطلب', textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (myRequestController.isDetailsLoading.value) {
            return LoadingIndicator();
          }
          if (myRequestController.orderItemService.isEmpty) {
            return const Center(child: Text("فشل تحميل المنتجات"));
          }

          return ListView.builder(
            itemCount: myRequestController.orderItemService.length,
            itemBuilder: (context, index) {
              final item = myRequestController.orderItemService[index];
              final quantity = int.tryParse(item.comnt) ?? 1;
              final originalPrice =
                  double.tryParse(item.purchasePrice ?? "") ?? 0.0;
              final currentPrice = double.tryParse(item.price) ?? 0.0;

              // حساب الخصم إن وُجد
              final discount =
                  originalPrice > 0 && currentPrice < originalPrice
                      ? ((originalPrice - currentPrice) / originalPrice * 100)
                          .toInt()
                      : 0;

              return Container(
                // height: 100,
                margin: const EdgeInsets.only(bottom: 16.0),
                decoration: BoxDecoration(
                  color: ColorApp.borderColor.withAlpha(50),

                  border: Border.all(color: ColorApp.borderColor),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ColorApp.borderColor.withAlpha(150),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(Values.circle),
                            topRight: Radius.circular(Values.circle),
                          ),
                        ),
                        width: 128,
                        height: 128,
                        child: Stack(
                          children: [
                            imageCached(item.img ?? ''),
                            if (discount > 0)
                              Container(
                                margin: EdgeInsets.all(Values.circle * .5),
                                width: 44,
                                height: 44,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ColorApp.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                child: Text(
                                  'خصم\n%$discount',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),

                      // التفاصيل
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // اسم المنتج
                            Text(
                              item.prodname,
                              style: StringStyle.textButtom.copyWith(
                                color: ColorApp.blackColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'الملاحظة',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${item.note}\n\n\n',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: Values.spacerV),

                            Row(
                              children: [
                                if (originalPrice > 0 &&
                                    currentPrice < originalPrice)
                                  Text(
                                    '${item.curncy} ${formatCurrency(originalPrice.toString())}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    ),
                                  ),
                                if (originalPrice > 0 &&
                                    currentPrice < originalPrice)
                                  const SizedBox(width: 8),
                                Text(
                                  formatCurrency(currentPrice.toString()),
                                  style: StringStyle.textLabilBold.copyWith(
                                    color: ColorApp.primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'الكمية: $quantity',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
