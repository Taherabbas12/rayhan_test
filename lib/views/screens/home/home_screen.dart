// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import '../../../controllers/home_controller.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/values_constant.dart';
import 'header_home.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            HeaderHome(),
            SizedBox(height: Values.spacerV * 2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Values.spacerV),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                    homeController.widgetHomes.map((e) => homeView(e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget homeView(WidgetHome home) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(Values.circle * .5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(Values.spacerV),
              splashColor: ColorApp.iconHomeColor,
              onTap: home.toPage,
              child: Container(
                margin: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: ColorApp.iconHomeColor,
                  border: Border.all(color: ColorApp.borderColor),
                  borderRadius: BorderRadius.circular(Values.spacerV),
                ),

                height: Values.width * .25,
                child: Image.asset(home.image),
              ),
            ),
            Text(
              home.name,
              style: StringStyle.headerStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
