import 'package:flutter/material.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';

import '../../../utils/constants/color_app.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإشعارات', style: StringStyle.headLineStyle2),
        foregroundColor: ColorApp.primaryColor,
      ),
      body: Center(child: Text('الإشعارات', style: StringStyle.headLineStyle2)),
    );
  }
}
