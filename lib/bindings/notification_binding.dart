import 'package:get/get.dart';

import '../controllers/notfication_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotficationController>(
      () => NotficationController(),
      fenix: true,
    );
  }
}
