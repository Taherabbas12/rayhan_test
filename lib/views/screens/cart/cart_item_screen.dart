import 'package:flutter/material.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/style_app.dart';
import '../../../utils/constants/values_constant.dart';
import 'request_rayhan.dart';

class CartItemScreen extends StatelessWidget {
  CartItemScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: const Text('السلة'), centerTitle: true),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              buildTaxiTabs(), // TabBar بدون أيقونات
              const SizedBox(height: 10),

              Expanded(
                child: TabBarView(children: [RequestRayhan(), RequestRayhan()]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTaxiTabs() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: -1,
          child: Divider(color: ColorApp.borderColor, height: 0, thickness: 2),
        ),
        TabBar(
          indicator: UnderlineTabIndicator(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Values.spacerV * 5),
              topRight: Radius.circular(Values.spacerV * 5),
            ),
            borderSide: BorderSide(width: 4, color: ColorApp.primaryColor),
          ),
          dividerColor: ColorApp.borderColor,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.symmetric(
            horizontal: Values.spacerV * 2,
          ),
          labelColor: ColorApp.primaryColor,
          unselectedLabelColor: Colors.black,
          indicatorColor: ColorApp.primaryColor,
          labelStyle: StringStyle.headerStyle,
          unselectedLabelStyle: StringStyle.headerStyle.copyWith(
            color: ColorApp.subColor,
            fontSize: 16,
          ),

          indicatorAnimation: TabIndicatorAnimation.elastic,
          splashBorderRadius: BorderRadius.circular(Values.circle),
          tabs: [Tab(text: 'خدمات ريحان'), Tab(text: 'طلبات ريحان')],
        ),
      ],
    );
  }
}
