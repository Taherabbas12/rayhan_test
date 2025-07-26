// OrdersForUser?id=1087
import 'package:get/get.dart';

import '../data/models/order_model.dart';
import '../data/models/user_model.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';
import 'storage_controller.dart';

class MyRequestController extends GetxController {
  RxList<OrderModel> orders = RxList([]);
  RxBool isLoading = RxBool(false);
  List<String> orderTypes = ['الحالية', 'المكتملة'];
  RxString selectType = 'الحالية'.obs;
  void changeType(String type) {
    selectType.value = type;
  }

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    isLoading.value = true;

    try {
      UserModel userModel = UserModel.fromJson(StorageController.getAllData());

      final StateReturnData response = await ApiService.getData(
        ApiConstants.getOrders(userModel.id),
      );
      logger.e(response.data);
      if (response.isStateSucess < 3) {
        List<dynamic> newVideosJson = response.data;

        List<OrderModel> newOrders =
            OrderModel.fromJsonList(newVideosJson).reversed.toList();
        orders.clear();
        orders.addAll(newOrders);
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    }

    isLoading.value = false;
  }
}
