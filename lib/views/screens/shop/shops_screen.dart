import 'package:flutter/material.dart';

import '../../../utils/constants/color_app.dart';
import 'shop_list.dart';
import 'view_list_categores_shop.dart';

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
    );
  }
}
