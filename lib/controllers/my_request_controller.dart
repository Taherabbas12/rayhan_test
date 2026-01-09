// OrdersForUser?id=1087
import 'package:get/get.dart';
import 'package:rayhan_test/routes/app_routes.dart';

import '../data/models/order_model.dart';
import '../data/models/user_model.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';
import 'storage_controller.dart';

class MyRequestController extends GetxController {
  RxList<OrderModel> orders = RxList([]);
  RxBool isLoading = RxBool(false);
  RxBool isDetailsLoading = RxBool(false);
  RxList<OrderItem> orderItem = RxList<OrderItem>([]);
  RxList<OrderItem> orderItemService = RxList<OrderItem>([]);

  // الطلب الحالي المحدد
  Rx<OrderModel?> selectedOrder = Rx<OrderModel?>(null);

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
      // logger.e(response.data);
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

  //

  Future<void> fetchOrderDetails(int id, {OrderModel? order}) async {
    isDetailsLoading.value = true;
    selectedOrder.value = order; // تخزين الطلب المحدد

    try {
      orderItem.clear();
      Get.toNamed(AppRoutes.orderDetailsScreen);

      final StateReturnData response = await ApiService.getData(
        ApiConstants.getOrderDetils(id),
      );
      logger.w('----------------_ A ------------');
      logger.w(response.data);
      logger.w('----------------_ B ------------');

      if (response.isStateSucess < 3) {
        List<dynamic> newVideosJson = response.data;

        List<OrderItem> newOrders =
            OrderItem.fromJsonList(newVideosJson).reversed.toList();

        orderItem.addAll(newOrders);
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    }

    isDetailsLoading.value = false;
  }

  Future<void> fetchOrderDetailsService(int id) async {
    isDetailsLoading.value = true;

    try {
      orderItem.clear();
      Get.toNamed(AppRoutes.orderDetailsScreenServices);

      final StateReturnData response = await ApiService.getData(
        ApiConstants.getOrderDetils(id, type: 'rayhan'),
      );
      logger.w('----------------_ A ------------');
      logger.w(response.data);
      logger.w('----------------_ B ------------');

      if (response.isStateSucess < 3) {
        List<dynamic> newVideosJson = response.data;

        List<OrderItem> newOrders =
            OrderItem.fromJsonList(newVideosJson).reversed.toList();

        orderItemService.addAll(newOrders);
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    }

    isDetailsLoading.value = false;
  }
}
