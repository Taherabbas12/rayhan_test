// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import '../../../utils/constants/color_app.dart';
import 'nav_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.whiteColor,
      body: PageView(
        controller: homeController.pageController,

        onPageChanged: homeController.changeIndexPage,
        children:
            homeController.homeViews.map((view) => view.builder()).toList(),
      ), // Add this line to show the bottom navigation bar
      bottomNavigationBar: NavBar(),
    );
  }
}
