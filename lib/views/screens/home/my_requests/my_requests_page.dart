import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/views/widgets/common/loading_indicator.dart';

import '../../../../controllers/my_request_controller.dart';
import '../../../../data/models/order_model.dart';
import '../../../../utils/constants/color_app.dart' show ColorApp;
import '../../../../utils/constants/style_app.dart';
import '../../../../utils/constants/values_constant.dart';
import 'categores_orders.dart';
import 'request_widget.dart';
import 'services/view_service.dart';

class MyRequestsPage extends StatelessWidget {
  MyRequestsPage({super.key});
  MyRequestController myRequestController = Get.find<MyRequestController>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          AppBar(title: Text('طلباتي')),
          buildTaxiTabs(),

          Expanded(
            child: TabBarView(
              children: [
                requestRayhan(),
                // 2
                ViewService(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column requestRayhan() {
    return Column(
      children: [
        SizedBox(height: Values.spacerV),

        CategoresOrders(),
        Expanded(
          child: Obx(() {
            List<OrderModel> orders = [];
            if (myRequestController.selectType.value ==
                myRequestController.orderTypes[0]) {
              orders =
                  myRequestController.orders
                      .where((e) => e.status != 'done')
                      .toList();
            } else {
              orders =
                  myRequestController.orders
                      .where((e) => e.status == 'done')
                      .toList();
            }
            return myRequestController.isLoading.value
                ? LoadingIndicator()
                : RefreshIndicator(
                  onRefresh:
                      () =>
                          myRequestController
                              .fetchOrders(), // تأكد أن هذه الدالة موجودة في الكنترولر وتقوم بجلب البيانات
                  child:
                      orders.isEmpty
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
                            itemCount: orders.length,
                            itemBuilder:
                                (context, index) =>
                                    RequestWidget(orderModel: orders[index]),
                          ),
                );
          }),
        ),
      ],
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
          tabs: [Tab(text: 'طلبات ريحان'), Tab(text: 'خدمات ريحان')],
        ),
      ],
    );
  }
}
