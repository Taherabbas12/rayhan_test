import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/routes/app_routes.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import '../../../controllers/auth_controller.dart' show AuthController;
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/values_constant.dart';
import '../../widgets/actions_button.dart';
import '../../widgets/input_text.dart';
import 'phone_field_widget.dart';

class Register extends StatelessWidget {
  Register({super.key});
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Values.circle),
            child: Text(
              '1/2',
              style: StringStyle.textButtom.copyWith(
                color: ColorApp.blackColor,
              ),
            ),
          ),
        ],
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: Values.circle * 5),
          child: LinearProgressIndicator(
            value: .5,
            color: ColorApp.primaryColor,
            borderRadius: BorderRadius.circular(Values.circle),
            minHeight: 12,
            backgroundColor: ColorApp.backgroundColor2,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Values.circle * 2),
        child: ListView(
          padding: EdgeInsets.all(Values.circle),
          children: [
            Text('أضف لمستك الشخصية👤', style: StringStyle.headLineStyle),
            SizedBox(height: Values.circle),
            Text(
              'لتعزيز تجربتك للتطبيق في طلب الخدمات، نود أن نعرف المزيد عنك.',
              style: StringStyle.textTitle.copyWith(
                color: ColorApp.textSecondryColor,
              ),
            ),
            SizedBox(height: Values.spacerV * 2),
            Text('الاسم الكامل', style: StringStyle.headerStyle),
            SizedBox(height: Values.circle),
            InputText.inputStringValidator(
              h: 60,
              'اكتب اسمك الكامل',
              authController.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال اسمك الكامل';
                }
                return null;
              },
            ),
            SizedBox(height: Values.spacerV),
            Text('رقم الهاتف', style: StringStyle.headerStyle),
            SizedBox(height: Values.circle),

            PhoneFieldWidget(
              w: 50,
              controller: authController.phoneNumber,
              enabled: false,
            ),
            SizedBox(height: Values.spacerV),
            Text('تاريخ الميلاد', style: StringStyle.headerStyle),
            SizedBox(height: Values.circle),

            InputText.inputDatePicker(
              name: 'اختر تاريخ ميلادك',
              context: context,
              controller: authController.birthDay,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال تاريخ ميلادك';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(Values.spacerV),
        child: Obx(
          () => BottonsC.action1(
            elevation: 0,
            'التالي',
            () {
              if (authController.isCompleteFormRegester().value) {
                // authController.registerUser();
                Get.toNamed(AppRoutes.registerComplete);
              }
            },
            color:
                authController.isCompleteFormRegester().value
                    ? ColorApp.primaryColor
                    : ColorApp.borderColor,
            colorText: ColorApp.whiteColor,
          ),
        ),
      ),
    );
  }
}
