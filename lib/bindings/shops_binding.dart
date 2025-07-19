import 'package:get/get.dart';
import '../controllers/shop_controller.dart';
import '../controllers/shops_controller.dart';

class ShopsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopsController>(() => ShopsController(), fenix: true);
    Get.lazyPut<ShopController>(() => ShopController(), fenix: true);
  }
}
