import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/my_request_services_controller.dart';
import '../../../../../utils/constants/values_constant.dart';
import '../../../../widgets/common/loading_indicator.dart';
import '../request_widget.dart';
import 'categores_orders_services.dart';
import 'request_widget_service.dart';

class ViewService extends StatelessWidget {
  ViewService({super.key});
  final MyRequestServicesController myRequestController =
      Get.find<MyRequestServicesController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Values.spacerV),

        CategoresOrdersServices(),
        Expanded(
          child: Obx(
            () =>
                myRequestController.isLoading.value
                    ? LoadingIndicator()
                    : RefreshIndicator(
                      onRefresh:
                          () =>
                              myRequestController
                                  .fetchOrdersServices(), // تأكد أن هذه الدالة موجودة في الكنترولر وتقوم بجلب البيانات
                      child:
                          myRequestController.orders.isEmpty
                              ? ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: const [
                                  SizedBox(height: 100),
                                  Center(child: Text('لا يوجد طلبات بعد')),
                                ],
                              )
                              : ListView.separated(
                                separatorBuilder:
                                    (context, index) =>
                                        SizedBox(height: Values.circle),
                                itemCount: myRequestController.orders.length,
                                itemBuilder:
                                    (context, index) => RequestWidgetService(
                                      orderModel:
                                          myRequestController.orders[index],
                                    ),
                              ),
                    ),
          ),
        ),
      ],
    );
  }
}
