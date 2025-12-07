// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import 'package:rayhan_test/utils/validators.dart';
import '../../../controllers/auth_controller.dart' show AuthController;
import '../../../controllers/taxi_controller.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/values_constant.dart';
import '../../widgets/actions_button.dart';
import '../../widgets/input_text.dart';
import '../services/taxi/inside_bismayah.dart';

class RegisterComplete extends StatelessWidget {
  RegisterComplete({super.key});
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Values.circle),
            child: Text(
              '2/2',
              style: StringStyle.textButtom.copyWith(
                color: ColorApp.blackColor,
              ),
            ),
          ),
        ],
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: Values.circle * 5),
          child: LinearProgressIndicator(
            value: 1,
            color: ColorApp.primaryColor,
            borderRadius: BorderRadius.circular(Values.circle),
            minHeight: 12,
            backgroundColor: ColorApp.backgroundColor2,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Values.circle * 2),
        child: Form(
          key: authController.formKeyRegister,
          child: ListView(
            padding: EdgeInsets.all(Values.circle),
            children: [
              InputText.inputStringValidator(
                margin: EdgeInsets.symmetric(vertical: Values.circle * .5),
                validator:
                    (p0) => Validators.notEmpty(p0, 'اسم العنوان المختصر'),

                'اسم العنوان المختصر',
                authController.nickName,
              ),
              SizedBox(height: Values.spacerV),

              hintText(),
              SizedBox(height: Values.spacerV),
              Row(
                children: [
                  inputDropDown(
                    hintText: 'اختر البلوك',
                    labelText: 'البلوك',
                    items:
                        taxiAddresses
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                    initialValue: authController.selectedTaxi.value,
                    onChanged: (value) {
                      authController.selectTaxi(value);
                    },
                  ),
                  SizedBox(width: Values.circle * 2),
                  Obx(() {
                    final selectedTaxi = authController.selectedTaxi.value;
                    final selectedAddress =
                        authController.selectedTaxiAddress.value;
                    return selectedTaxi == null
                        ? Expanded(child: SizedBox())
                        : inputDropDown(
                          hintText: 'اختر البناية',
                          labelText: 'البناية',
                          items:
                              selectedTaxi.addresses
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                          initialValue: selectedAddress,
                          onChanged: (value) {
                            authController.selectTaxiAddress(value as String);
                          },
                        );
                  }),
                
                
                
                
                
                
                ],
              ),

           SizedBox(height: Values.spacerV),
              Row(
                children: [
                  Obx(() {
                    final selectedTaxi =
                        authController.selectedTaxiAddress.value;
                    final selectedRoof =
                        authController.selectedTaxiRoofNo.value;

                    return selectedTaxi == null
                        ? const Expanded(child: SizedBox())
                        : Expanded(
                          child: inputDropDown(
                            hintText: 'اختر الطابق',
                            labelText: 'الطابق',
                            items:
                                roofNo
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),

                            /// ✔ حل المشكلة هنا
                            initialValue:
                                roofNo.contains(selectedRoof)
                                    ? selectedRoof
                                    : null,

                            onChanged: (value) {
                              authController.selectTaxiRoofNo(value);
                            },
                          ),
                        );
                  }),
                  SizedBox(width: Values.circle * 2),
                  Obx(() {
                    final selectedRoof =
                        authController.selectedTaxiRoofNo.value;
                    final selectedHome =
                        authController.selectedTaxiHomeNo.value;

                    return selectedRoof == null
                        ? const Expanded(child: SizedBox())
                        : Expanded(
                          child: inputDropDown(
                            hintText: 'الشقة',
                            labelText: 'رقم الشقة',
                            items:
                                homeNo
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ) 
                                    )
                                    .toList(),

                            /// ✔ التصحيح هنا أيضاً
                            initialValue:
                                homeNo.contains(selectedHome)
                                    ? selectedHome
                                    : null,

                            onChanged: (value) {
                              authController.selectTaxiHomeNo(value as String);
                            },
                          ),
                        );
                  }),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(Values.spacerV),
        child: Obx(
          () => BottonsC.action1(
            elevation: 0,
            'تأكيد',
            () {
            authController.  formKeyRegister.currentState?.validate(); 
              if (authController.isCompleteFormRegester().value) {
                authController.registerUser();
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

  Widget hintText() {
    return Container(
      height: 60,

      decoration: BoxDecoration(
        color: ColorApp.primaryColor,
        borderRadius: BorderRadius.circular(Values.circle),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Icon(
              CupertinoIcons.exclamationmark_circle_fill,
              color: ColorApp.whiteColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              'يُرجى ادخال بيانات العنوان بدقة لتحقيق افضل خدمة توصيل لطلباتكم.',
              style: StringStyle.headerStyle.copyWith(
                color: ColorApp.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
