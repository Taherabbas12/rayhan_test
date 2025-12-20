import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/views/widgets/common/loading_indicator.dart';
import '../../../controllers/my_address_controller.dart';
import '../../../controllers/taxi_controller.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/style_app.dart';
import '../../../utils/constants/values_constant.dart';
import '../../../utils/validators.dart';
import '../../widgets/actions_button.dart';
import '../../widgets/input_text.dart';
import '../services/taxi/inside_bismayah.dart';

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({super.key});

  final MyAddressController controller = Get.find<MyAddressController>();

  @override
  Widget build(BuildContext context) {
    controller.cleanData();
    return Scaffold(
      appBar: AppBar(title: const Text("إضافة عنوان جديد"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Values.circle * 2),
        child: Form(
          key: controller.formKeyRegister,
          child: ListView(
            padding: EdgeInsets.all(Values.circle),
            children: [
              InputText.inputStringValidator(
                margin: EdgeInsets.symmetric(vertical: Values.circle * .5),
                validator:
                    (p0) => Validators.notEmpty(p0, 'اسم العنوان المختصر'),

                'اسم العنوان المختصر',
                controller.nickName,
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
                    initialValue: controller.selectedTaxi.value,
                    onChanged: (value) {
                      controller.selectTaxi(value);
                    },
                  ),
                  SizedBox(width: Values.circle * 2),
                  Obx(() {
                    final selectedTaxi = controller.selectedTaxi.value;
                    final selectedAddress =
                        controller.selectedTaxiAddress.value;
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
                            controller.selectTaxiAddress(value as String);
                          },
                        );
                  }),
                ],
              ),

              SizedBox(height: Values.spacerV),
              Row(
                children: [
                  Obx(() {
                    final selectedTaxi = controller.selectedTaxiAddress.value;
                    final selectedRoof = controller.selectedTaxiRoofNo.value;

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
                              controller.selectTaxiRoofNo(value);
                            },
                          ),
                        );
                  }),
                  SizedBox(width: Values.circle * 2),
                  Obx(() {
                    final selectedRoof = controller.selectedTaxiRoofNo.value;
                    final selectedHome = controller.selectedTaxiHomeNo.value;

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
                                      ),
                                    )
                                    .toList(),

                            /// ✔ التصحيح هنا أيضاً
                            initialValue:
                                homeNo.contains(selectedHome)
                                    ? selectedHome
                                    : null,

                            onChanged: (value) {
                              controller.selectTaxiHomeNo(value as String);
                            },
                          ),
                        );
                  }),
                ],
              ),

              //
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
                    'تأكيد',
                    () {
                      if (controller.formKeyRegister.currentState!.validate()) {
                        controller.addAddress();
                      }
                    },
                    color: ColorApp.primaryColor,
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
