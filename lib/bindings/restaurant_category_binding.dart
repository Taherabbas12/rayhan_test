import 'package:get/get.dart';
import '../controllers/restaurant_category_controller.dart';

class RestaurantCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestaurantCategoryController>(
      () => RestaurantCategoryController(),
      fenix: true,
    );
  }
}
