// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/views/widgets/message_snak.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/style_app.dart';
import '../../../utils/constants/values_constant.dart';
import '../../widgets/actions_button.dart';
import '../../widgets/common/loading_indicator.dart';

class Login extends StatelessWidget {
  Login({super.key});
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Values.spacerV),
                  child: ListView(
                    children: [
                      SizedBox(height: Values.spacerV * 6),
                      Center(
                        child: Image.asset(
                          width: 182,
                          height: 182,
                          'assets/svg/Screenshot_2025-02-25_210755-removebg-preview.png',
                        ),
                      ),
                      SizedBox(height: Values.spacerV * 2),
                      Center(
                        child: Text(
                          'مرحبا بك في ريحان ! 👋',
                          textAlign: TextAlign.center,
                          style: StringStyle.headLineStyle,
                        ),
                      ),
                      Center(
                        child: Text(
                          'العديد من الخدمات والمنتجات بخصومات كبيرة في إنتظارك.',
                          textAlign: TextAlign.center,
                          style: StringStyle.textTitle,
                        ),
                      ),
                      SizedBox(height: Values.spacerV * 2),
                      Text('رقم الهاتف', style: StringStyle.textTitle),
                      SizedBox(height: Values.circle),
                      Form(
                        key: authController.formKeyLogin,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorApp.subColor.withAlpha(150),
                              width: 0.5,
                            ),

                            borderRadius: BorderRadius.circular(
                              Values.circle * 0.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: PhoneInputField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    // labelText: 'رقم الهاتف',
                                    hintText: 'اكتب رقمك هنا',
                                  ),
                                  onChanged: (value) {
                                    authController.numberInput.value =
                                        value.dialCode;
                                    print(authController.numberInput.value);
                                  },
                                  onPhoneNumberValidated: (
                                    isValid,
                                    phoneNUmber,
                                  ) {
                                    if (isValid) {
                                      debugPrint(
                                        'Phone number: ${phoneNUmber!.number}',
                                      );
                                      debugPrint(
                                        'Internationalized phone number: ${phoneNUmber.internationalizedPhoneNumber}',
                                      );
                                      debugPrint(
                                        'ISO code: ${phoneNUmber.internationalizedPhoneNumber}',
                                      );
                                    } else {
                                      debugPrint('Invalid phone number');
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: CountryCodePicker(
                                  mode: CountryCodePickerMode.bottomSheet,
                                  onChanged: (country) {
                                    print(
                                      'Country code selected: ${country.code}',
                                    );
                                  },
                                  initialSelection: 'IQ',
                                  dialogBackgroundColor:
                                      ColorApp.backgroundColor,
                                  searchDecoration: InputDecoration(
                                    fillColor: ColorApp.whiteColor,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 15,
                                    ),
                                    // border: OutlineInputBorder(
                                    //     borderRadius:
                                    //         BorderRadius.circular(Values.circle), // تدوير الحواف
                                    //     borderSide: BorderSide.none), // إزالة الحدود
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorApp.subColor.withAlpha(150),
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        Values.circle * 0.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorApp.greenColor.withAlpha(
                                          150,
                                        ),
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        Values.circle,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        Values.circle,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorApp.redColor.withAlpha(150),
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorApp.redColor.withAlpha(150),
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        Values.circle,
                                      ),
                                    ),
                                    label: Container(
                                      decoration: BoxDecoration(
                                        // color: ColorApp.backgroundColor2,
                                        borderRadius: BorderRadius.circular(
                                          Values.circle,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 5,
                                      ),
                                      child: Text(
                                        'ابحث عن دولتك',
                                        style: StringStyle.textTable.copyWith(
                                          color: ColorApp.subColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  showFlag: true,
                                  showDropDownButton: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Checkbox(
                              activeColor: ColorApp.primaryColor,
                              side: BorderSide(
                                color: ColorApp.primaryColor,
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  Values.circle * 0.6,
                                ),
                              ),
                              value: authController.rememberMe.value,
                              onChanged: authController.changeRememberMe,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: Values.circle),
                              child: RichText(
                                text: TextSpan(
                                  text: 'من خلال إنشاء حساب, فإنك توافق على ',
                                  style: StringStyle.textLabil,
                                  children: [
                                    TextSpan(
                                      text: 'الشروط والاحكام ',
                                      style: StringStyle.textLabil.copyWith(
                                        color: ColorApp.primaryColor,
                                      ),
                                      recognizer:
                                          TapGestureRecognizer()
                                            // هنا يمكنك تحديد ما يحدث عند النقر على النص
                                            ..onTap =
                                                () => MessageSnak.message(
                                                  'لم يتم اضافة الشروط والاحكام بعد',
                                                ),
                                    ),
                                    TextSpan(
                                      text: 'الخاصة بنا',
                                      style: StringStyle.textLabil,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Values.spacerV * 2),
                    ],
                  ),
                ),
              ),

              Divider(thickness: 1, color: ColorApp.borderColor),
              SizedBox(height: Values.spacerV * 1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Values.spacerV),
                child: Obx(
                  () => BottonsC.action1(
                    'تأكيد',
                    () {
                      if (authController.rememberMe.value) {
                        authController.submitFormLogin();
                      }
                    },
                    color:
                        authController.rememberMe.value
                            ? ColorApp.primaryColor
                            : ColorApp.borderColor,
                    colorText:
                        authController.rememberMe.value
                            ? ColorApp.whiteColor
                            : ColorApp.subColor,
                  ),
                ),
              ),
              //
              SizedBox(height: Values.spacerV),
            ],
          ),
          Obx(
            () =>
                authController.isLoading.value
                    ? BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 2,
                        sigmaY: 2,
                      ), // قوة التمويه
                      child: Container(
                        color: ColorApp.primaryColor.withAlpha(
                          100,
                        ), // يجب أن تكون الشفافية هنا
                      ),
                    )
                    : SizedBox(),
          ),
          Obx(
            () =>
                authController.isLoading.value
                    ? Center(
                      child: Container(
                        height: 150,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Values.spacerV),
                          color: ColorApp.backgroundColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadingIndicator(),
                            Text(
                              'تسجيل  الدخول ...',
                              style: StringStyle.textButtom.copyWith(
                                color: ColorApp.backgroundColorContent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    : SizedBox(),
          ),
        ],
      ),
    );
  }
}
