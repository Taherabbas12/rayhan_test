// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../controllers/auth_controller.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/images_url.dart';
import '../../../utils/constants/style_app.dart';
import '../../../utils/constants/values_constant.dart';
import '../../widgets/actions_button.dart';
import '../../widgets/common/loading_indicator.dart';

class OTPScreen extends StatelessWidget {
  AuthController authController = Get.find<AuthController>();

  OTPScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Values.spacerV * 6),
            // Center(
            //   child: Image.asset(
            //     width: 182,
            //     height: 182,
            //     'assets/svg/Screenshot_2025-02-25_210755-removebg-preview.png',
            //   ),
            // ),🔐
            // SizedBox(height: Values.spacerV),
            SizedBox(height: Values.spacerV * 1),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'أدخل رمز ال OTP 🔐',
                style: StringStyle.headLineStyle2,
              ),
            ),
            SizedBox(height: Values.spacerV * 1),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'تحقق من صندوق رسائلك بحثاََ عن رسالة من ريحان ,أدخل رمز التحقق لمرة واحدة أدناه للمتابعة في تأكيد حسابك . ',
                style: StringStyle.textTitle,
              ),
            ),
            SizedBox(height: Values.spacerV),

            SizedBox(height: Values.spacerV * 2),
            Pinput(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              length: 4, // عدد الأرقام في الرمز
              controller: authController.otpController,
              defaultPinTheme: PinTheme(
                width: 84,
                height: 65,
                textStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              focusedPinTheme: PinTheme(
                width: 84,
                height: 65,
                textStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorApp.primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              submittedPinTheme: PinTheme(
                width: 84,
                height: 65,
                textStyle: TextStyle(
                  fontSize: 25,
                  color: ColorApp.blackColor,
                  fontWeight: FontWeight.w600,
                ),
                decoration: BoxDecoration(
                  // color: ColorApp.backgroundColorContent,
                  border: Border.all(color: ColorApp.borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onCompleted: (pin) => authController.submitFormOTP(),
            ),
            SizedBox(height: Values.spacerV * 3),

            Center(
              child: Obx(
                () => RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'يمكنك إعادة ارسال الكود خلال ',
                    style: StringStyle.headerStyle,
                    children: [
                      TextSpan(
                        text: '${authController.remainingTime} ',
                        style: StringStyle.headerStyle.copyWith(
                          color: ColorApp.primaryColor,
                        ),
                      ),
                      TextSpan(text: 'ثانية.', style: StringStyle.headerStyle),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () =>
              //
              CupertinoButton(
                onPressed: authController.reSendOTPMessage,
                child: Text(
                  'أعد إرسال الرمز',
                  style: StringStyle.headerStyle.copyWith(
                    color:
                        authController.remainingTime > 0
                            ? ColorApp.borderColor
                            : ColorApp.primaryColor,
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Values.spacerV),
              child: Obx(
                () =>
                    authController.isLoading.value
                        ? LoadingIndicator()
                        : BottonsC.action1(
                          'تحقق',
                          authController.submitFormOTP,
                        ),
              ),
            ),
            SizedBox(height: Values.spacerV * 2),
          ],
        ),
      ),
    );
  }
}
