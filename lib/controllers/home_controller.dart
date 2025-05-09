import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../utils/constants/images_url.dart';

class HomeController extends GetxController {
  List<WidgetHome> widgetHomes = [
    WidgetHome('الطعام', ImagesUrl.imageResturant, AppRoutes.resturantsScreen),
    WidgetHome('الماركت', ImagesUrl.imageMarket, AppRoutes.resturantsScreen),
    WidgetHome('المتاجر', ImagesUrl.imageMatajer, AppRoutes.resturantsScreen),
    WidgetHome('الخدمات', ImagesUrl.imageServices, AppRoutes.servicesScreen),
  ];
}

class WidgetHome {
  String name;
  String image;
  String page;
  WidgetHome(this.name, this.image, this.page);
  void toPage() => Get.toNamed(page);
}
