import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/services/error_message.dart';

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

  late UserModel user;

  @override
  void onInit() {
    super.onInit();

    user = UserModel.fromJson(StorageController.getAllData());

    nameController = TextEditingController(text: user.name);
    phoneController = TextEditingController(text: user.phone);
    birthController = TextEditingController(text: user.birthday);
  }

  Future<void> updateProfile() async {
    isLoading(true);

    final data = {
      "name": nameController.text,
      "phone": phoneController.text.replaceAll(" ", ""),
      "birthday": birthController.text,
    };

    try {
      final response = await ApiService.postData(
        ApiConstants.updateUser(user.id.toString()),
        data,
      );
      logger.w(response.data);
      if (response.isStateSucess < 3) {
        // تحديث التخزين
        user.name = nameController.text;
        user.phone = phoneController.text;
        user.birthday = birthController.text;

        StorageController.storeData(user.toJson());

        MessageSnak.message("تم تحديث بيانات الحساب بنجاح");
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
