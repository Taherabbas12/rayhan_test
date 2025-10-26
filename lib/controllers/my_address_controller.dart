import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/address_model.dart';
import '../data/models/user_model.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/values_constant.dart';
import 'storage_controller.dart';
import 'taxi_controller.dart';

class MyAddressController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingStart = true.obs;
  Rx<Taxi?> selectedTaxi = Rx<Taxi?>(null);
  Rx<String?> selectedTaxiAddress = Rx<String?>(null);
  final GlobalKey<FormState> formKeyRegister = GlobalKey<FormState>();

  void selectTaxi(Taxi taxi) {
    selectedTaxiAddress.value = null;
    selectedTaxi.value = taxi;
  }

  void selectTaxiAddress(String address) {
    selectedTaxiAddress.value = address;
  }

  RxBool isCompleteForm = false.obs;

  final TextEditingController homeNo = TextEditingController();

  final TextEditingController roofNo = TextEditingController();
  final TextEditingController blockNo = TextEditingController();
  final TextEditingController nickName = TextEditingController();

  // ✅ دالة إضافة عنوان جديد
  Future<void> addAddress() async {
    try {
      // ✅ التحقق من أن الحقول مملوءة (اختياري لكن موصى به)
      if (selectedTaxiAddress.value == null ||
          selectedTaxi.value == null ||
          nickName.text.isEmpty) {
        Get.snackbar("تنبيه", "يرجى ملء جميع الحقول المطلوبة");
        return;
      }

      isLoading.value = true;

      UserModel userModel = UserModel.fromJson(StorageController.getAllData());

      // ✅ بناء جسم الطلب حسب المطلوب
      final Map<String, dynamic> addressData = {
        "homeNo": homeNo.text.trim(),
        "buildingNo": selectedTaxiAddress.value!.trim(),
        "roofNo": roofNo.text.trim(),
        "blockNo": selectedTaxi.value!.name.trim(),
        "nickName": nickName.text.trim(),
        "inBasmaya": true,
        "userid": userModel.id.toString(),
      };

      final StateReturnData response = await ApiService.postData(
        ApiConstants.tbAddresses,
        addressData, // 👈 هنا نمرر البيانات الفعلية
      );

      if (response.isStateSucess < 3) {
        // ✅ نجاح الإضافة
        await fetchAddresses(); // تحديث القائمة
        Get.back(); // العودة إلى الشاشة السابقة
        Get.snackbar(
          "نجاح",
          "تمت إضافة العنوان بنجاح ✅",
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green,
        );
      } else {
        // ❌ فشل الإضافة
        Get.snackbar(
          "خطأ",
          "فشل في إضافة العنوان",
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        "خطأ",
        "حدث خطأ أثناء الإضافة: $e",
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  RxList<AddressModel> addresses = <AddressModel>[].obs;
  Rx<AddressModel?> addressSelect = Rx(null);

  RxInt countView() =>
      (Values.width ~/ 250 == 0 ? 1 : (Values.width / 250).round()).obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    isLoading.value = true;
    try {
      final StateReturnData response = await ApiService.getData(
        ApiConstants.tbAddresses,
      );

      if (response.isStateSucess < 3 && response.data != null) {
        List<dynamic> newJson = response.data;
        final allAddresses = AddressModel.fromJsonList(newJson);

        UserModel userModel = UserModel.fromJson(
          StorageController.getAllData(),
        );

        final filteredAddresses =
            allAddresses
                .where((address) => address.userid == userModel.id.toString())
                .toList();

        addresses.assignAll(filteredAddresses);
        if (addresses.isNotEmpty) {
          addressSelect(addresses.first);
        }
      } else {
        // logger.e("لم يتم تحميل البيانات بنجاح");
      }
    } catch (e) {
      // logger.e(e);
    }
    isLoadingStart(false);
    isLoading.value = false;
  }
}
