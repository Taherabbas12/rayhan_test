import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';

import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';

class TaxiScreen extends StatelessWidget {
  const TaxiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('حدد نقطة الانطلاق'),
          centerTitle: false,
        ),
        body: Column(
          children: [
            hintText(),
            const SizedBox(height: 10),
            buildTaxiTabs(), // TabBar بدون أيقونات
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                children: [
                  buildTaxiContent('داخل بسماية'),

                  buildTaxiContent('خارج بسماية'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget hintText() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Values.spacerV * 1.5),
      decoration: BoxDecoration(
        color: ColorApp.primaryColor,
        borderRadius: BorderRadius.circular(Values.circle),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Icon(
              CupertinoIcons.map_pin_ellipse,
              color: ColorApp.whiteColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              'يرجى تحديد نقطة الانطلاق التي سيتوجه السائق إليها ليقلك منها',
              style: StringStyle.headerStyle.copyWith(
                color: ColorApp.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTaxiTabs() {
    return TabBar(

      indicator:
      
      
       UnderlineTabIndicator(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Values.spacerV * 5),
          topRight: Radius.circular(Values.spacerV * 5),
        ),
        borderSide: BorderSide(width: 4, color: ColorApp.primaryColor),
      ),

      labelColor: ColorApp.primaryColor,
      unselectedLabelColor: Colors.black,
      indicatorColor: ColorApp.primaryColor,
      labelStyle: StringStyle.headerStyle,

      tabs: [Tab(text: 'داخل بسماية'), Tab(text: 'خارج بسماية')],
    );
  }

  Widget buildTaxiContent(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/taxi.png', width: 200, height: 200),
          const SizedBox(height: 20),
          Text(title, style: StringStyle.headerStyle),
        ],
      ),
    );
  }
}
