import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../utils/constants/color_app.dart';
import '../views/widgets/message_snak.dart';

class AuthController extends GetxController {
  // خصائص
  RxBool isLoading = false.obs;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController jobTitle = TextEditingController();
  final TextEditingController nationality = TextEditingController();
  RxString numberInput = RxString('');
  // OTP
  final TextEditingController otpController = TextEditingController();
  // اعادة ارسال ال OTP

  void reSendOTPMessage() {
    remainingTime(30);
    startTimer();
    //
  }

  void submitFormOTP() async {
    isLoading(true);
    MessageSnak.message('تم التحقق من ال OTP', color: ColorApp.greenColor);
    await Future.delayed(Duration(seconds: 1));

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

  Rx<String?> selectedCountry = Rx('');
  void changeContry(String? newValue) {
    selectedCountry.value = newValue;
  }

  //تذكرني
  RxBool rememberMe = false.obs;
  void changeRememberMe(bool? value) {
    rememberMe.value = value!;
  }

  // مفتاح النموذج
  final formKeyLogin = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();
  final formKeyRePassword = GlobalKey<FormState>();
  void submitFormLogin() async {
    if (formKeyLogin.currentState!.validate()) {
      isLoading(true);

      MessageSnak.message(
        'تم إرسال البيانات بنجاح',
        color: ColorApp.greenColor,
      );
    } else {
      MessageSnak.message('يرجى ملاء كل الحقول ');
    }
    await Future.delayed(Duration(seconds: 2));
    startTimer();
    Get.toNamed(AppRoutes.otp);
    MessageSnak.message('تم إرسال  OTP', color: ColorApp.greenColor);

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
    // تحرير الموارد عند إغلاق الـ Controller
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    fullName.dispose();
    phoneNumber.dispose();
    jobTitle.dispose();
    nationality.dispose();
    super.onClose();
  }
}
