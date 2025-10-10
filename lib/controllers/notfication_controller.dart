import 'package:get/get.dart';

import '../data/models/notification_model.dart';
import '../data/models/user_model.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';
import 'storage_controller.dart';

class NotficationController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<NotificationModel> productsShop = RxList([]);

  @override
  void onInit() {
    super.onInit();
    fetchNotification();
  }

  Future<void> fetchNotification() async {
    isLoading.value = true;
    UserModel userModel = UserModel.fromJson(StorageController.getAllData());
    try {
      final StateReturnData response = await ApiService.getData(
        ApiConstants.getNotifications(userModel.id),
      );

      if (response.isStateSucess < 3) {
        List<dynamic> newJson = response.data;

        List<NotificationModel> newShopCategores =
            NotificationModel.fromJsonList(newJson);
        productsShop.clear();
        // shopCategores.add(ShopCategory(id: 0, name: "الكل"));
        productsShop.addAll(newShopCategores);
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    }

    isLoading.value = false;
  }
}
