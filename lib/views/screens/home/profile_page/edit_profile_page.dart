import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/profile_edit_controller.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/style_app.dart';
import '../../../../utils/constants/values_constant.dart';
import '../../../widgets/input_text.dart';
import '../../auth/phone_field_widget.dart';

class EditProfilePage extends StatelessWidget {
  final ProfileEditController controller = Get.find<ProfileEditController>();

  EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تعديل الحساب", style: StringStyle.titleApp),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(
        () =>
            controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : Form(
                  key: controller.formKey,
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: Values.circle * 2,
                      vertical: Values.circle,
                    ),
                    children: [
                      // العنوان الرئيسي
                      Text(
                        'تحديث بياناتك الشخصية 👤',
                        style: StringStyle.headLineStyle,
                      ),
                      SizedBox(height: Values.circle),
                      Text(
                        'يمكنك تعديل معلوماتك الشخصية من هنا.',
                        style: StringStyle.textTitle.copyWith(
                          color: ColorApp.textSecondryColor,
                        ),
                      ),
                      SizedBox(height: Values.spacerV * 2),

                      // الاسم الكامل
                      Text('الاسم الكامل', style: StringStyle.headerStyle),
                      SizedBox(height: Values.circle),
                      InputText.inputStringValidator(
                        h: 60,
                        'اكتب اسمك الكامل',
                        controller.nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال اسمك الكامل';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: Values.spacerV),

                      // رقم الهاتف
                      Text('رقم الهاتف', style: StringStyle.headerStyle),
                      SizedBox(height: Values.circle),
                      PhoneFieldWidget(
                        w: 50,
                        controller: controller.phoneController,
                        enabled: true,
                      ),
                      SizedBox(height: Values.spacerV),

                      // تاريخ الميلاد
                      Text('تاريخ الميلاد', style: StringStyle.headerStyle),
                      SizedBox(height: Values.circle),
                      InputText.inputDatePicker(
                        name: 'اختر تاريخ ميلادك',
                        context: context,
                        controller: controller.birthController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال تاريخ ميلادك';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: Values.spacerV * 3),

                      // زر حفظ التعديلات
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorApp.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: controller.updateProfile,
                          child: Text(
                            "حفظ التعديلات",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
