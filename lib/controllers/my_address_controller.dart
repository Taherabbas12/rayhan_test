import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/address_model.dart';
import '../data/models/user_model.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/color_app.dart';
import '../utils/constants/values_constant.dart';
import '../views/widgets/message_snak.dart';
import 'storage_controller.dart';
import 'taxi_controller.dart';

class MyAddressController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingStart = true.obs;
  Rx<String?> selectedTaxiAddress = Rx<String?>(null);
  final GlobalKey<FormState> formKeyRegister = GlobalKey<FormState>();
  Rx<String?> selectedTaxiRoofNo = Rx<String?>(null);
  Rx<String?> selectedTaxiHomeNo = Rx<String?>(null);
  void fillForEdit(AddressModel address) {
    nickName.text = address.nickName;

    selectedTaxi.value = taxiAddresses.firstWhereOrNull(
      (e) => e.name == address.blockNo,
    );

    selectedTaxiAddress.value =
        address.buildingNo.isNotEmpty ? address.buildingNo : null;
    logger.w(address.roofNo);
    logger.w(address.roofNo.isNotEmpty);
    logger.w('---a');
    selectedTaxiRoofNo.value =
        address.roofNo.isNotEmpty ? address.roofNo : null;
    selectedTaxiHomeNo.value =
        address.homeNo.isNotEmpty ? address.homeNo : null;
  }

  void selectTaxi(Taxi taxi) {
    selectedTaxiAddress.value = null;
    selectedTaxiRoofNo.value = null;
    selectedTaxiHomeNo.value = null;
    selectedTaxi.value = taxi;
  }

  void selectTaxiAddress(String address) {
    selectedTaxiRoofNo.value = null;
    selectedTaxiHomeNo.value = null;
    selectedTaxiAddress.value = address;
  }

  void selectTaxiRoofNo(String roofNo) {
    selectedTaxiHomeNo.value = null;
    selectedTaxiRoofNo.value = roofNo;
  }

  void selectTaxiHomeNo(String homeNo) {
    selectedTaxiHomeNo.value = homeNo;
  }

  RxBool isCompleteForm = false.obs;

  final TextEditingController nickName = TextEditingController();
  Rx<Taxi?> selectedTaxi = Rx<Taxi?>(null);
  void cleanData() {
    selectedTaxiAddress.value = null;
    selectedTaxi.value = null;
    selectedTaxiRoofNo.value = null;
    selectedTaxiHomeNo.value = null;
    nickName.text = '';
  }

  // ✅ دالة إضافة عنوان جديد
  Future<void> addAddress() async {
    try {
      if (selectedTaxiAddress.value == null ||
          selectedTaxi.value == null ||
          selectedTaxiRoofNo.value == null ||
          selectedTaxiHomeNo.value == null ||
          nickName.text.isEmpty) {
        MessageSnak.message('يرجى ملء جميع الحقول المطلوبة');

        return;
      }

      isLoading.value = true;

      UserModel userModel = UserModel.fromJson(StorageController.getAllData());

      // ✅ بناء جسم الطلب حسب المطلوب
      final Map<String, dynamic> addressData = {
        "homeNo": selectedTaxiHomeNo.value,
        "buildingNo": selectedTaxiAddress.value!.trim(),
        "roofNo": selectedTaxiRoofNo.value,
        "blockNo": selectedTaxi.value!.name,
        "nickName": nickName.text.trim(),
        "inBasmaya": true,
        "userid": userModel.id.toString(),
      };
      logger.w(addressData);
      final StateReturnData response = await ApiService.postData(
        ApiConstants.tbAddresses,
        addressData, // 👈 هنا نمرر البيانات الفعلية
      );
      logger.w(response.data);

      if (response.isStateSucess < 3) {
        // ✅ نجاح الإضافة
        await fetchAddresses(); // تحديث القائمة
        Get.back(); // العودة إلى الشاشة السابقة
        MessageSnak.message(
          'تمت إضافة العنوان بنجاح ✅',
          color: ColorApp.greenColor,
        );
      } else {
        MessageSnak.message('فشل في إضافة العنوان');
        // ❌ فشل الإضافة
      }
    } catch (e) {
      MessageSnak.message('حدث خطأ أثناء الإضافة: $e');
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

  //
  Future<void> deleteAddress(int id) async {
    try {
      isLoading(true);

      final StateReturnData response = await ApiService.deleteData(
        ApiConstants.tbAddressesById(id.toString()),
      );
      logger.w(response.data);
      if (response.isStateSucess < 3 && response.data != null) {
        MessageSnak.message('تم حذف العنوان بنجاح', color: ColorApp.greenColor);

        fetchAddresses();
      }
    } catch (e) {
      MessageSnak.message('فشل حذف العنوان');
    } finally {
      isLoading(false);
    }
  }

  // Future<void> updateAddress(int id) async {
  //   try {
  //     isLoading(true);

  //     final body = {
  //       "homeNo": selectedTaxiHomeNo.value,
  //       "buildingNo": selectedTaxiAddress.value,
  //       "roofNo": selectedTaxiRoofNo.value,
  //       "blockNo": selectedTaxi.value?.name,
  //       "nickName": nickName.text.trim(),
  //       "inBasmaya": true,
  //     };

  //     final StateReturnData response = await ApiService.putData(
  //       ApiConstants.tbAddressesById(id.toString()),
  //       body,
  //     );
  //     logger.w(response.data);
  //     if (response.isStateSucess < 3 && response.data != null) {
  //       MessageSnak.message(
  //         'تم تعديل العنوان بنجاح',
  //         color: ColorApp.greenColor,
  //       );

  //       fetchAddresses();

  //       Get.back();
  //     }
  //   } catch (e) {
  //     MessageSnak.message('فشل تعديل العنوان');
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future<void> updateAddress(int addressId) async {
    try {
      if (selectedTaxiAddress.value == null ||
          selectedTaxi.value == null ||
          selectedTaxiRoofNo.value == null ||
          selectedTaxiHomeNo.value == null ||
          nickName.text.isEmpty) {
        MessageSnak.message('يرجى ملء جميع الحقول المطلوبة');
        return;
      }

      isLoading.value = true;

      final Map<String, dynamic> addressData = {
        "id": addressId,
        "homeNo": selectedTaxiHomeNo.value,
        "buildingNo": selectedTaxiAddress.value!.trim(),
        "roofNo": selectedTaxiRoofNo.value,
        "blockNo": selectedTaxi.value!.name,
        "nickName": nickName.text.trim(),
        "inBasmaya": true,
        "userid":
            UserModel.fromJson(StorageController.getAllData()).id.toString(),
      };

      final StateReturnData response = await ApiService.putData(
        ApiConstants.tbAddressesById(addressId.toString()),
        addressData,
      );
      logger.w('00------000');
      logger.w(response.data);
      logger.w('11------111');

      if (response.isStateSucess < 3) {
        await fetchAddresses(); // تحديث القائمة
        Get.back(); // العودة
        MessageSnak.message(
          'تم تحديث العنوان بنجاح ✅',
          color: ColorApp.greenColor,
        );
      } else {
        MessageSnak.message('فشل تحديث العنوان');
      }
    } catch (e) {
      MessageSnak.message('خطأ: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
