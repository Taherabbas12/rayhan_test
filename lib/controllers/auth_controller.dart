import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/color_app.dart';
import '../views/widgets/message_snak.dart';

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
    remainingTime(30);
    startTimer();
    //
  }

  void submitFormOTP() async {
    isLoading(true);
    await Future.delayed(Duration(seconds: 1));
    if (otpController.text == otpCode) {
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
  final formKeyLogin = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();
  final formKeyRePassword = GlobalKey<FormState>();
  void submitFormLogin() async {
    isLoading(true);

    MessageSnak.message('تم إرسال البيانات بنجاح', color: ColorApp.greenColor);

    try {
      otpCode =
          '${DateTime.now().millisecondsSinceEpoch % 1000000}'; // رقم عشوائي مكون من 6 أرقام
      final StateReturnData response = await ApiService.postData(
        ApiConstants.smsSendWhats,
        {
          "recipient": "964${phoneNumber.value.text}",
          "sender_id": "Rayhan",
          "type": "whatsapp",
          "message": otpCode, // رقم عشوائي مكون من 6 أرقام
          "lang": "ar",
        },
      );

      logger.e("response $otpCode    ");
      logger.e("response ${response.data}    ");
      if (response.isStateSucess < 3) {
        if (response.data['status'] == 'success') {
          otpCode = response.data['data']['message'];
          MessageSnak.message('تم إرسال OTP بنجاح', color: ColorApp.greenColor);
          await Future.delayed(Duration(seconds: 2));
          startTimer();
          Get.toNamed(AppRoutes.otp);
          isLoading(false);

          MessageSnak.message('تم إرسال  OTP', color: ColorApp.greenColor);
        } else {
          otpCode = '';
        }
      } else {
        MessageSnak.message('فشل في إرسال OTP', color: ColorApp.redColor);
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    }

    isLoading(false);
  }

  void submitFormRegister() async {
    if (formKeyRegister.currentState!.validate()) {
      isLoading(true);
      startTimer();
      Get.toNamed(AppRoutes.otp);
      MessageSnak.message('تم إرسال  OTP', color: ColorApp.greenColor);
    } else {
      isLoading(true);
      await Future.delayed(Duration(seconds: 1));
      startTimer();
      Get.toNamed(AppRoutes.otp);
      MessageSnak.message('يرجى ملاء كل الحقول ');
    }
    // Get.toNamed(AppRoutes.home);

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
