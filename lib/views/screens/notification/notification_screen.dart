import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';

import '../../../controllers/notfication_controller.dart';
import '../../../utils/constants/color_app.dart';
import '../../widgets/more_widgets.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  NotficationController controller = Get.find<NotficationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإشعارات', style: StringStyle.headLineStyle2),
        foregroundColor: ColorApp.primaryColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.productsShop.isEmpty) {
          return Center(
            child: Text('لا توجد إشعارات', style: StringStyle.headLineStyle2),
          );
        } else {
          return ListView.builder(
            itemCount: controller.productsShop.length,
            itemBuilder: (context, index) {
              final notification = controller.productsShop[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    notification.title,
                    style: StringStyle.headLineStyle,
                  ),
                  subtitle: Text(notification.body),
                  trailing: Text(
                    getFormattedDate(notification.date),
                    style: StringStyle.headerStyle.copyWith(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
