import 'package:flutter/material.dart';

import '../../../data/models/cart_item.dart';
import '../../../utils/constants/color_app.dart';
import '../../widgets/more_widgets.dart';
import 'market_list.dart';

class MarketScreen extends StatelessWidget {
  MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorApp.backgroundColor,
        elevation: 0,
        title: Text('الماركات'),
      ),
      body: MarketList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: cartShowInScreenTotal(CartType.mart),
    );
  }
}
