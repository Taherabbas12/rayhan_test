import 'package:flutter/material.dart';

import '../../../utils/constants/color_app.dart';
import 'market_list.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

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
    );
  }
}
