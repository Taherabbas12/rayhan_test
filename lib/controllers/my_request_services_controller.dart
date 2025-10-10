// OrdersForUser?id=1087
import 'package:get/get.dart';

import '../data/models/order_service_model.dart';
import '../data/models/user_model.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';
import 'storage_controller.dart';

class MyRequestServicesController extends GetxController {
  RxList<OrderServiceModel> orders = RxList([]);
  RxBool isLoading = RxBool(false);
 static List<OrderStatues> orderTypes = [
    OrderStatues(name: 'الحالية', nameEn: 'needAction'),
    OrderStatues(name: 'المكتملة', nameEn: 'complete'),
  ];

  Rx<OrderStatues> selectType = orderTypes[0].obs;
  void changeType(OrderStatues type) {
    selectType.value = type;
    fetchOrdersServices();
  }

  @override
  void onInit() {
    super.onInit();
    fetchOrdersServices();
  }

  Future<void> fetchOrdersServices() async {
    isLoading.value = true;

    try {
      UserModel userModel = UserModel.fromJson(StorageController.getAllData());

      final StateReturnData response = await ApiService.postData(
        ApiConstants.getOrdersServices(userModel.id, selectType.value.nameEn),
        {},
      );
      logger.e(response.data);
      if (response.isStateSucess < 3) {
        print(response.data);
        if (response.data is List) {
          List<dynamic> newOrdersJson = response.data;

          // الخطوة 2: حوّل القائمة إلى List<OrderServiceModel>
          List<OrderServiceModel> newOrders =
              OrderServiceModel.fromJsonList(newOrdersJson).reversed.toList();
          orders.clear();
          orders.addAll(newOrders);
          // الآن newOrders تحتوي على جميع الطلبات ✅
        } else {
          logger.e("⚠️ Expected a List but got: ${response.data.runtimeType}");
        }
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    }

    isLoading.value = false;
  }
}

class OrderStatues {
  String name;
  String nameEn;
  OrderStatues({required this.name, required this.nameEn});
}
