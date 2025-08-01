import 'package:flutter/material.dart';

import '../../../data/models/cart_item.dart';
import '../../../utils/constants/color_app.dart';
import '../../widgets/more_widgets.dart';
import 'shop_list.dart';

class ShopsScreen extends StatelessWidget {
  const ShopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorApp.backgroundColor,
        elevation: 0,
        title: Text('المتاجر'),
      ),
      body: ListView(children: [ShopLists()]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: cartShowInScreenTotal(CartType.shop),
    );
  }
}
