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
import 'taxi_controller.dart';

class AuthController extends GetxController {
  // مفتاح النموذج
  final GlobalKey<FormState> formKeyRegister = GlobalKey<FormState>();
  // بيانات العنوان الأول (الانطلاق)
  Rx<Taxi?> selectedTaxi = Rx<Taxi?>(null);
  Rx<String?> selectedTaxiAddress = Rx<String?>(null);

  void selectTaxi(Taxi taxi) {
    selectedTaxiAddress.value = null;
    selectedTaxi.value = taxi;
  }

  void selectTaxiAddress(String address) {
    selectedTaxiAddress.value = address;
  }

  // خصائص
  RxBool isLoading = false.obs;
  RxBool isCompleteForm = false.obs;
  RxBool isCompleteFormRegester() =>
      (birthDay.text.isNotEmpty && name.text.isNotEmpty).obs;
  final TextEditingController phoneNumber = TextEditingController();

  final TextEditingController name = TextEditingController();
  final TextEditingController birthDay = TextEditingController();
  final TextEditingController homeNo = TextEditingController();
  final TextEditingController buildingNo = TextEditingController();
  final TextEditingController roofNo = TextEditingController();
  final TextEditingController blockNo = TextEditingController();
  final TextEditingController nickName = TextEditingController();

  //
  RxBool loginWithOtpStatus = false.obs;
  RxString deviceID = ''.obs;
  RxDouble lat = 0.0.obs;
  RxDouble lang = 0.0.obs;
  //
  Future<void> registerUser() async {
    final data = {
      "tbUser": {
        "phone": setTruePhoneNumber(),
        "type": "user",
        "admin": "false",
        "active": "true",
        "isBusy": "false",
        "star": "false",
        "lat": lat.value.toString(),
        "lang": lang.value.toString(),
        "deviecidx": deviceID.value.toString(), // معرف الجهاز
        "pass": '123456',
        "name": name.text,
        "birthday": birthDay.text,
      },
      "tbAddress": {
        "homeNo": homeNo.text, // رقم المنزل
        "buildingNo": buildingNo.text, // رقم البناية
        "roofNo": roofNo.text, // رقم السطح
        "blockNo": blockNo.text, // رقم القطعة
        "nickName": nickName.text,
        "inBasmaya": "true",
      },
    };

    try {
      final StateReturnData response = await ApiService.postData(
        ApiConstants.smsSendWhats,
        data,
      );

      logger.e("response ${response.data}   | ");
      if (response.isStateSucess < 3) {
        Get.toNamed(AppRoutes.home);
      } else {
        Get.toNamed(AppRoutes.home);
        // MessageSnak.message('فشل في تسجيل المستخدم', color: ColorApp.redColor);
      }
    } catch (e) {
      // logger.i("خطأ في تحميل البيانات: $e");
      Get.toNamed(AppRoutes.home);
    } finally {
      ApiService.updateTokenString(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJZb3VyU3ViamVjdCIsImp0aSI6Ijc2Y2YxNWVlLWMyOWItNDg2MC1hODhkLTBiMDU4YjY3NWYyYyIsImlhdCI6IjcvMTMvMjAyNSA1OjM0OjEwIFBNIiwiZXhwIjoyNTM0MDIzMDA4MDAsImlzcyI6IllvdXJJc3N1ZXIiLCJhdWQiOiJZb3VyQXVkaWVuY2UifQ._6fGCfpFIPWBCaEbGRbX4LBmxu-sB7j-ZmtgSm3rMno',
      );
      isLoading(false);
    }

    isLoading(false);
  }

  String setTruePhoneNumber() {
    // قم بتعديل هذه الدالة حسب الحاجة
    return phoneNumber.text.replaceAll(" ", "").replaceAll("+", "");
  }

  //
  RxString numberInput = RxString('');
  // OTP
  final TextEditingController otpController = TextEditingController();

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
      if (responseLogin != null) {
        logger.e("responseLogin ${responseLogin!.data}   | ");
        await StorageController.storeData(responseLogin!.data);
        Get.toNamed(AppRoutes.home);
      }
      responseLogin;
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
    ;
  }

  StateReturnData? responseLogin;
  // مفتاح النموذج
  var dateOtp;
  void submitFormLogin() async {
    isLoading(true);

    try {
      logger.i(
        "phoneNumber ${phoneNumber.value.text}  | rememberMe ${rememberMe.value}",
      );
      responseLogin = await ApiService.postData(
        ApiConstants.login(
          '0${phoneNumber.value.text.replaceAll(RegExp(r'\s+'), '')}',
        ),
        {},
      );

      logger.e("response $otpCode   | ");
      logger.e("response ${responseLogin!.data}   | ");
      if (responseLogin!.isStateSucess < 3) {
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
            MessageSnak.message(
              'تم إرسال OTP بنجاح',
              color: ColorApp.greenColor,
            );
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
      } else {
        MessageSnak.message(
          'تاكد من صحة رقم الهاتف أوكلمة المرور',
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
