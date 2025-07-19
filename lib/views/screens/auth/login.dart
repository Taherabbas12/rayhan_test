// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/views/widgets/message_snak.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/images_url.dart';
import '../../../utils/constants/style_app.dart';
import '../../../utils/constants/values_constant.dart';
import '../../widgets/actions_button.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/input_text.dart';
import 'phone_field_widget.dart';

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
                          ImagesUrl.logoPNG,
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
                      SizedBox(height: Values.spacerV * .4),

                      Center(
                        child: Text(
                          'العديد من الخدمات والمنتجات بخصومات كبيرة في إنتظارك.',
                          textAlign: TextAlign.center,
                          style: StringStyle.textTitle.copyWith(
                            color: ColorApp.textSecondryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: Values.spacerV * 2),
                      Text('رقم الهاتف', style: StringStyle.headerStyle),
                      SizedBox(height: Values.circle),

                      PhoneFieldWidget(controller: authController.phoneNumber),
                      SizedBox(height: Values.spacerV * 1.5),

                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,

                        child: InputText.inputStringValidatorIcon(
                          'كلمة المرور',
                          icon: Icons.lock_outline,
                          margin: EdgeInsets.all(0),

                          isPassword: true,

                          authController.pass,
                          onChanged: (p0) {
                            authController.password.value = p0 ?? '';

                            authController.isCompleteForm.value =
                                authController.phoneNumber.text.length == 14 &&
                                authController.rememberMe.value &&
                                authController.password.value.length >= 6;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال كلمة المرور';
                            }
                            if (value.length < 6) {
                              return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                            }
                            return null;
                          },
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
                                  text: 'من خلال إنشاء حساب , فإنك توافق على ',
                                  style: StringStyle.textLabil.copyWith(
                                    color: ColorApp.textSecondryColor,
                                  ),
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
                                      style: StringStyle.textLabil.copyWith(
                                        color: ColorApp.textSecondryColor,
                                      ),
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

              Divider(thickness: .5, color: ColorApp.borderColor),
              SizedBox(height: Values.spacerV * .5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Values.spacerV),
                child: Obx(
                  () => BottonsC.action1(
                    elevation: 0,
                    'تأكيد',
                    () {
                      if (authController.isCompleteForm.value) {
                        authController.submitFormLogin();
                      }
                    },
                    color:
                        authController.isCompleteForm.value
                            ? ColorApp.primaryColor
                            : ColorApp.borderColor,
                    colorText:
                        authController.isCompleteForm.value
                            ? ColorApp.whiteColor
                            : ColorApp.subColor,
                  ),
                ),
              ),
              //
              SizedBox(height: Values.spacerV * 1.5),
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
