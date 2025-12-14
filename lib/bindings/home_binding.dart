import 'package:get/get.dart';
import '../controllers/cart_item_controller.dart';
import '../controllers/favorites_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/home_get_all_controller.dart';
import '../controllers/market_controller.dart';
import '../controllers/market_product_controller.dart';
import '../controllers/my_address_controller.dart';
import '../controllers/my_request_controller.dart';
import '../controllers/my_request_services_controller.dart';
import '../controllers/restaurant_controller.dart';
import '../controllers/shop_controller.dart';
import '../controllers/shops_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeGetAllController>(
      () => HomeGetAllController(),
      fenix: true,
    );

    Get.lazyPut<MyAddressController>(() => MyAddressController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<MarketController>(() => MarketController(), fenix: true);
    Get.lazyPut<ShopsController>(() => ShopsController(), fenix: true);
    Get.lazyPut<ShopController>(() => ShopController(), fenix: true);
    Get.lazyPut<MarketProductController>(
      () => MarketProductController(),
      fenix: true,
    );
    Get.lazyPut<CartItemController>(() => CartItemController(), fenix: true);
    Get.lazyPut<MyRequestController>(() => MyRequestController(), fenix: true);
    Get.lazyPut<MyRequestServicesController>(
      () => MyRequestServicesController(),
      fenix: true,
    );
    Get.lazyPut<RestaurantController>(
      () => RestaurantController(),
      fenix: true,
    );
    Get.put<FavoritesController>(FavoritesController(), permanent: true);
  }
}
