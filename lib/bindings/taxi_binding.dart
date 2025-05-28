import 'package:get/get.dart';
import '../controllers/taxi_controller.dart';

class TaxiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaxiController>(() => TaxiController(), fenix: true);
  }
}
