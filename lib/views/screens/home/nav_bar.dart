import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/color_app.dart';
import 'package:rayhan_test/views/widgets/common/svg_show.dart';

import '../../../controllers/home_controller.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        elevation: 5,
        items:
            homeController.homeViews.map((view) {
              return BottomNavigationBarItem(
                icon: svgImage(
                  view.image,
                  color: ColorApp.subColor,
                  hi: 22,
                  wi: 22,
                ),
                label: view.name,
                activeIcon: svgImage(view.image, color: ColorApp.primaryColor),
              );
            }).toList(),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorApp.primaryColor,

        unselectedItemColor: ColorApp.subColor,
        currentIndex: homeController.currentIndex.value,
        onTap: homeController.changeIndex,
      ),
    );
  }
}
