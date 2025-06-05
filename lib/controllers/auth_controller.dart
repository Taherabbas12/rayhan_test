import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/color_app.dart';
import '../views/widgets/message_snak.dart';
import 'storage_controller.dart';

class AuthController extends GetxController {
  // خصائص
  RxBool isLoading = false.obs;
  RxBool isCompleteForm = false.obs;
  final TextEditingController phoneNumber = TextEditingController();

  RxString numberInput = RxString('');
  // OTP
  final TextEditingController otpController = TextEditingController();
  // اعادة ارسال ال OTP

  @override
  void onInit() {
    super.onInit();
    phoneNumber.addListener(() {
      isCompleteForm.value = phoneNumber.text.length == 14 && rememberMe.value;
    });
  }

  void reSendOTPMessage() {
    remainingTime(60);
    submitFormLogin();
    startTimer();
    //
  }

  void submitFormOTP() async {
    isLoading(true);
    await Future.delayed(Duration(seconds: 1));
    if (otpController.text == otpCode) {
      await StorageController.storeData(dateOtp);
      Get.toNamed(AppRoutes.home);
      MessageSnak.message(
        'تم التحقق من ال OTP بنجاح',
        color: ColorApp.greenColor,
      );
    } else {
      MessageSnak.message('رمز OTP غير صحيح', color: ColorApp.redColor);
    }
    isLoading(false);
  }

  RxInt remainingTime = 60.obs; // الوقت المتبقي (يبدأ من 30)
  late Timer _timer;
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--; // تقليل الوقت المتبقي كل ثانية
      } else {
        timer.cancel(); // إيقاف المؤقت عند الوصول إلى الصفر
      }
    });
  }

  String otpCode = '';
  Rx<String?> selectedCountry = Rx('');
  void changeContry(String? newValue) {
    selectedCountry.value = newValue;
  }

  //تذكرني
  RxBool rememberMe = false.obs;
  void changeRememberMe(bool? value) {
    rememberMe.value = value!;
    isCompleteForm.value = phoneNumber.text.length == 14 && rememberMe.value;
  }

  // مفتاح النموذج
  var dateOtp;
  void submitFormLogin() async {
    isLoading(true);

    try {
      otpCode = '${DateTime.now().millisecondsSinceEpoch % 1000000}';
      final StateReturnData response =
          await ApiService.postData(ApiConstants.smsSendWhats, {
            "recipient": "964${phoneNumber.value.text}",
            "sender_id": "Rayhan",
            "type": "whatsapp",
            "message": otpCode,
            "lang": "ar",
          });

      logger.e("response $otpCode   | ");
      logger.e("response ${response.data}   | ");
      if (response.isStateSucess < 3) {
        if (response.data['status'] == 'success') {
          otpCode = response.data['data']['message'];
          MessageSnak.message('تم إرسال OTP بنجاح', color: ColorApp.greenColor);
          await Future.delayed(Duration(seconds: 2));
          startTimer();
          Get.toNamed(AppRoutes.otp);
          isLoading(false);
          dateOtp = response.data;
          MessageSnak.message('تم إرسال  OTP', color: ColorApp.greenColor);
        } else {
          otpCode = '';
        }
      } else {
        MessageSnak.message(
          'فشل في إرسال OTP تاكد من رقم الهاتف',
          color: ColorApp.redColor,
        );
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    }

    isLoading(false);
  }

  void submitFormRePassword() async {
    isLoading(true);

    startTimer();

    MessageSnak.message('تم اعادة كلمة المرور   ', color: ColorApp.greenColor);

    await Future.delayed(Duration(seconds: 1));
    Get.toNamed(AppRoutes.home);
    isLoading(false);
  }

  @override
  void onClose() {
    phoneNumber.dispose();
    super.onClose();
  }
}
