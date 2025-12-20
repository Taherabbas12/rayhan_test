import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/profile_edit_controller.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/style_app.dart';
import '../../../../utils/constants/values_constant.dart';
import '../../../widgets/input_text.dart';

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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(Values.spacerV * 2),
                      child: Column(
                        children: [
                          /// الاسم
                          InputText.inputStringValidator(
                            "الاسم الكامل",
                            controller.nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "يرجى إدخال الاسم";
                              }
                              return null;
                            },
                            w: double.infinity,
                          ),

                          /// رقم الهاتف
                          InputText.inputStringValidator(
                            "رقم الهاتف",
                            controller.phoneController,
                            isNumber: 11, // ← يدعم دخول أرقام فقط + حد أقصى
                            validator: (value) {
                              if (value == null || value.length < 10) {
                                return "رقم الهاتف غير صحيح";
                              }
                              return null;
                            },
                            w: double.infinity,
                          ),

                          /// تاريخ الميلاد
                          InputText.inputStringValidator(
                            "تاريخ الميلاد",
                            controller.birthController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "يرجى إدخال تاريخ الميلاد";
                              }
                              return null;
                            },
                            w: double.infinity,
                          ),

                          SizedBox(height: Values.spacerV * 3),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorApp.primaryColor,
                              padding: EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 14,
                              ),
                            ),
                            onPressed: controller.updateProfile,
                            child: Text(
                              "حفظ التعديلات",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
      ),
    );
  }
}
