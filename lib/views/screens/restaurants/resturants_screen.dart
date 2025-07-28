import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_item_controller.dart';
import '../../../data/models/cart_item.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/style_app.dart';
import '../../../utils/constants/values_constant.dart';
import '../../widgets/more_widgets.dart';
import 'retaurant_list.dart';
import 'view_list_categores.dart';

class ResturantsScreen extends StatelessWidget {
  ResturantsScreen({super.key});
  final CartItemController cartItemController = Get.find<CartItemController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorApp.backgroundColor,
        elevation: 0,
        title: Text('المطاعم'),
      ),
      body: ListView(children: [ViewListCategores(), RetaurantList()]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: cartShowInScreenTotal(CartType.restaurant),
    );
  }
}
