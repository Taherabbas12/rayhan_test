import 'package:get/get.dart';
import '../controllers/market_product_controller.dart';

class MarketProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketProductController>(
      () => MarketProductController(),
      fenix: true,
    );
  }
}
