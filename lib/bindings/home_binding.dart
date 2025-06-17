import 'package:get/get.dart';
import '../controllers/cart_item_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/restaurant_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<CartItemController>(() => CartItemController(), fenix: true);
    Get.lazyPut<RestaurantController>(
      () => RestaurantController(),
      fenix: true,
    );
  }
}
