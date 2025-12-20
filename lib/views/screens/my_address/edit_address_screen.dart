// lib/views/screens/edit_address_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/views/widgets/common/loading_indicator.dart';
import '../../../controllers/my_address_controller.dart';
import '../../../controllers/taxi_controller.dart';
import '../../../data/models/address_model.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/style_app.dart';
import '../../../utils/constants/values_constant.dart';
import '../../../utils/validators.dart';
import '../../widgets/actions_button.dart';
import '../../widgets/input_text.dart';
import '../services/taxi/inside_bismayah.dart';

class EditAddressScreen extends StatelessWidget {
  final AddressModel address; // ← عنوان مطلوب للتعديل

  const EditAddressScreen({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyAddressController());

    // ملء الحقول عند بناء الشاشة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.cleanData();
      controller.fillForEdit(address);
    });

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('تعديل العنوان'), centerTitle: true),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Values.circle * 2),
          child: Form(
            key: controller.formKeyRegister,
            child: ListView(
              padding: EdgeInsets.all(Values.circle),
              children: [
                // 💡 ملاحظة توجيهية
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColorApp.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(Values.circle),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 20,
                        color: ColorApp.primaryColor,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'يُرجى تعديل بيانات العنوان بدقة.',
                          style: StringStyle.headerStyle.copyWith(
                            color: ColorApp.primaryColor,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Values.spacerV),

                // 📝 اسم العنوان المختصر
                InputText.inputStringValidator(
                  margin: EdgeInsets.zero,
                  validator:
                      (val) => Validators.notEmpty(val, 'اسم العنوان مطلوب'),
                  'اسم العنوان المختصر',
                  controller.nickName,
                ),
                SizedBox(height: Values.spacerV),

                // 🏢 البلوك + البناية
                Row(
                  children: [
                    Expanded(
                      child: inputDropDown(
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
                        initialValue: controller.selectedTaxi.value,
                        onChanged: (value) {
                          if (value != null) controller.selectTaxi(value);
                        },
                      ),
                    ),
                    SizedBox(width: Values.circle * 2),
                    Obx(() {
                      final selectedTaxi = controller.selectedTaxi.value;
                      final selectedAddress =
                          controller.selectedTaxiAddress.value;
                      return Expanded(
                        child:
                            selectedTaxi == null
                                ? SizedBox()
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
                                    if (value != null) {
                                      controller.selectTaxiAddress(
                                        value as String,
                                      );
                                    }
                                  },
                                ),
                      );
                    }),
                  ],
                ),
                SizedBox(height: Values.spacerV),

                // 🏠 الطابق + رقم الشقة
                Row(
                  children: [
                    Obx(() {
                      final selectedTaxi = controller.selectedTaxiAddress.value;
                      final selectedRoof = controller.selectedTaxiRoofNo.value;
                      return Expanded(
                        child:
                            selectedTaxi == null || selectedTaxi.isEmpty
                                ? SizedBox()
                                : inputDropDown(
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
                                  initialValue:
                                      roofNo.contains(selectedRoof)
                                          ? selectedRoof
                                          : null,
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.selectTaxiRoofNo(
                                        value as String,
                                      );
                                    }
                                  },
                                ),
                      );
                    }),
                    SizedBox(width: Values.circle * 2),
                    Obx(() {
                      final selectedRoof = controller.selectedTaxiRoofNo.value;
                      final selectedHome = controller.selectedTaxiHomeNo.value;
                      return Expanded(
                        child:
                            selectedRoof == null
                                ? SizedBox()
                                : inputDropDown(
                                  hintText: 'رقم الشقة',
                                  labelText: 'الشقة',
                                  items:
                                      homeNo
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ),
                                          )
                                          .toList(),
                                  initialValue:
                                      homeNo.contains(selectedHome)
                                          ? selectedHome
                                          : null,
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.selectTaxiHomeNo(
                                        value as String,
                                      );
                                    }
                                  },
                                ),
                      );
                    }),
                  ],
                ),
                SizedBox(height: Values.spacerV * 2),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.all(Values.spacerV),
          child: Obx(
            () =>
                controller.isLoading.value
                    ? LoadingIndicator()
                    : BottonsC.action1(
                      elevation: 0,
                      'تحديث',
                      () {
                        if (controller.formKeyRegister.currentState!
                            .validate()) {
                          controller.updateAddress(address.id);
                        }
                      },
                      color: ColorApp.primaryColor,
                      colorText: ColorApp.whiteColor,
                    ),
          ),
        ),
      ),
    );
  }
}
