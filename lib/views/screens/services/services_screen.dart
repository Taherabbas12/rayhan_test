// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../controllers/services_controller.dart';
import '../../../utils/constants/color_app.dart';
import 'product_widget_services.dart';
import 'view_services_categores.dart';

class ServicesScreen extends StatelessWidget {
  ServicesScreen({super.key});
  ServicesController servicesController = Get.find<ServicesController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.backgroundColor,
      appBar: AppBar(title: Text('الخدمات')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ViewListCategores(),
          Expanded(
            child: OrientationBuilder(
              builder: (context, orientation) {
                return Obx(
                  () => MasonryGridView.count(
                    crossAxisCount: servicesController.countView().value,

                    crossAxisSpacing: 10,

                    itemCount: servicesController.products.length,
                    itemBuilder:
                        (context, index) => ProductWidgetServices(
                          product: servicesController.products[index],
                        ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
