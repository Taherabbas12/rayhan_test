import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';

import '../../../../controllers/taxi_controller.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';
import '../../../widgets/actions_button.dart';
import 'inside_bismayah.dart';

class TaxiScreen extends StatelessWidget {
  TaxiScreen({super.key});
  final TaxiController taxiController = Get.find<TaxiController>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorApp.whiteColor,
        appBar: AppBar(
          title: Obx(() => Text(taxiController.textTitle.value.title)),
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
                children: [InsideBismayah(), buildTaxiContent('خارج بسماية')],
              ),
            ),
            Obx(
              () =>
                  !taxiController.isCompleteStartingPoint.value
                      ? nextButton(
                        onPressed:
                            () => taxiController.setCompleteStartingPoint(true),
                      )
                      : nextButton2(
                        onPressed:
                            () => taxiController.setCompleteEndPoint(true),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget nextButton({required VoidCallback onPressed, String? text}) {
    return SafeArea(
      // bottom: false,
      child: Container(
        decoration: BoxDecoration(
          color: ColorApp.whiteColor,
          border: Border(top: BorderSide(color: ColorApp.borderColor)),
        ),
        padding: EdgeInsets.only(
          left: Values.circle * 2.4,
          right: Values.circle * 2.4,

          top: Values.circle * 2.4,
        ),

        child: Obx(
          () => BottonsC.action1(
            text ?? 'التالي',
            onPressed,
            h: 58,
            elevation: 0,
            color:
                taxiController.selectedTaxiAddress.value != null
                    ? ColorApp.primaryColor
                    : ColorApp.borderColor,
            colorText:
                taxiController.selectedTaxiAddress.value == null
                    ? ColorApp.subColor
                    : ColorApp.whiteColor,
          ),
        ),
      ),
    );
  }

  Widget nextButton2({required VoidCallback onPressed, String? text}) {
    return SafeArea(
      // bottom: false,
      child: Container(
        decoration: BoxDecoration(
          color: ColorApp.whiteColor,
          border: Border(top: BorderSide(color: ColorApp.borderColor)),
        ),
        padding: EdgeInsets.only(
          left: Values.circle * 2.4,
          right: Values.circle * 2.4,

          top: Values.circle * 2.4,
        ),

        child: Obx(
          () => BottonsC.action1(
            text ?? 'التالي',
            onPressed,
            h: 58,
            elevation: 0,
            color:
                taxiController.selectedTaxiAddress2.value != null
                    ? ColorApp.primaryColor
                    : ColorApp.borderColor,
            colorText:
                taxiController.selectedTaxiAddress2.value == null
                    ? ColorApp.subColor
                    : ColorApp.whiteColor,
          ),
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
            child: Obx(
              () => Text(
                taxiController.textTitle.value.subtitle,
                style: StringStyle.headerStyle.copyWith(
                  color: ColorApp.whiteColor,
                ),
              ),
            ),
          ),
        ],
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
          tabs: [Tab(text: 'داخل بسماية'), Tab(text: 'خارج بسماية')],
        ),
      ],
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
