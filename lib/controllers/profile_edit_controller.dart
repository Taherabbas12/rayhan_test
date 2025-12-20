import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/services/error_message.dart';
import 'package:rayhan_test/utils/constants/color_app.dart';

import '../data/models/user_model.dart';
import '../services/api_service.dart';
import '../utils/constants/api_constants.dart';
import '../views/widgets/message_snak.dart';
import 'storage_controller.dart';

class ProfileEditController extends GetxController {
  RxBool isLoading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController birthController;
  RxString name = RxString('');
  RxString phone = RxString('');
  UserModel userModel = UserModel.fromJson(StorageController.getAllData());

  @override
  void onInit() {
    super.onInit();

    userModel = UserModel.fromJson(StorageController.getAllData());
    name.value = userModel.name;
    phone.value = userModel.phone;
    nameController = TextEditingController(text: userModel.name);
    phoneController = TextEditingController(text: userModel.phone);
    birthController = TextEditingController(text: userModel.birthday);
  }

  Future<void> updateProfile() async {
    isLoading(true);

    final data = {
      "name": nameController.text,
      "phone": phoneController.text.replaceAll(" ", ""),
      "birthday": birthController.text,
    };

    final patchData =
        data.entries
            .where(
              (entry) => entry.value.trim().isNotEmpty,
            ) // يستثني القيم الفارغة أو التي تحتوي على مسافات فقط
            .map(
              (entry) => {
                "path": "/${entry.key}",
                "op": "replace",
                "value": entry.value,
              },
            )
            .toList();
    try {
      final response = await ApiService.putData(
        ApiConstants.updataUser(userModel.id.toString()),
        patchData,
      );
      logger.w('------- User --------');
      logger.w(response.data);
      logger.w('------- User --------');

      if (response.isStateSucess < 3) {
        // تحديث التخزين
        userModel.name = nameController.text;
        userModel.phone = phoneController.text;
        userModel.birthday = birthController.text;

        StorageController.storeData(userModel.toJson());
        userModel = UserModel.fromJson(StorageController.getAllData());
        name.value = userModel.name;
        phone.value = userModel.phone;
        MessageSnak.message(
          "تم تحديث بيانات الحساب بنجاح",
          color: ColorApp.greenColor,
        );
        Get.back();
      } else {
        MessageSnak.message("فشل التعديل", color: Colors.red);
      }
    } catch (e) {
      MessageSnak.message("خطأ في الاتصال بالخادم", color: Colors.red);
    }

    isLoading(false);
  }
}
