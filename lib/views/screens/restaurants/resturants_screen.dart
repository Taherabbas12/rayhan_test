import 'package:flutter/material.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';

import '../../../utils/constants/color_app.dart';
import 'view_list_categores.dart';

class ResturantsScreen extends StatelessWidget {
  const ResturantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorApp.backgroundColor,
        elevation: 0,
        title: Text('الطعام', style: StringStyle.textTitle),
      ),
      body: ListView(
        children: [
          ViewListCategores()
        ],
      ),
    );
  }
}
