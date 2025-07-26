import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/views/widgets/common/loading_indicator.dart';

import '../../../../controllers/my_request_controller.dart';
import 'request_widget.dart';

class MyRequestsPage extends StatelessWidget {
  MyRequestsPage({super.key});
  MyRequestController myRequestController = Get.find<MyRequestController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(title: Text('طلباتي')),
        Expanded(
          child: Obx(
            () =>
                myRequestController.isLoading.value
                    ? LoadingIndicator()
                    : RefreshIndicator(
                      onRefresh:
                          () =>
                              myRequestController
                                  .fetchOrders(), // تأكد أن هذه الدالة موجودة في الكنترولر وتقوم بجلب البيانات
                      child:
                          myRequestController.orders.isEmpty
                              ? ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: const [
                                  SizedBox(height: 100),
                                  Center(child: Text('لا يوجد طلبات بعد')),
                                ],
                              )
                              : ListView.builder(
                                itemCount: myRequestController.orders.length,
                                itemBuilder:
                                    (context, index) => RequestWidget(
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
