import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../utils/constants/images_url.dart';
import '../views/screens/home/home_page/home_page.dart';
import '../views/screens/home/my_requests/my_requests_page.dart';
import '../views/screens/home/profile_page/profile_page.dart';
import '../views/screens/home/search_page/search_page.dart';

class HomeController extends GetxController {
  List<WidgetHome> widgetHomes = [
    WidgetHome('الطعام', ImagesUrl.imageResturant, AppRoutes.resturantsScreen),
    WidgetHome('الماركت', ImagesUrl.imageMarket, AppRoutes.marketScreen),
    WidgetHome('المتاجر', ImagesUrl.imageMatajer, AppRoutes.resturantsScreen),
    WidgetHome('الخدمات', ImagesUrl.imageServices, AppRoutes.servicesScreen),
  ];
  RxInt currentIndex = 0.obs;
  final PageController pageController = PageController(initialPage: 0);

  void changeIndex(int index) {
    currentIndex(index);
    pageController.jumpToPage(index); // ← الانتقال عند التغيير
  }

  void changeIndexPage(int index) {
    currentIndex(index);
  }

  Widget get viewBody => homeViews[currentIndex.value].builder();
  List<HomeView> homeViews = [
    HomeView('الرئيسية', ImagesUrl.homeIcon, () => HomePage()),
    HomeView('طلباتي', ImagesUrl.paperIcon, () => MyRequestsPage()),
    HomeView('البحث', ImagesUrl.searchIcon, () => SearchPage()),
    HomeView('الحساب', ImagesUrl.profileIcon, () => ProfilePage()),
  ];
}

class HomeView {
  String name;
  String image;
  Widget Function() builder;

  HomeView(this.name, this.image, this.builder);
}

class WidgetHome {
  String name;
  String image;
  String page;
  WidgetHome(this.name, this.image, this.page);
  void toPage() => Get.toNamed(page);
}
