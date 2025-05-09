// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/product_model.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/style_app.dart';
import '../../../../utils/constants/values_constant.dart';

class ProductWidgetServices extends StatelessWidget {
  ProductWidgetServices({super.key, required this.product});
  final Product product;
  RxBool isBasket = false.obs;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => Get.to(() => ViewProductScreen(product: product)),
      child: Container(
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   border: Border.all(color: ColorApp.borderColor, width: 1),
        //   borderRadius: BorderRadius.circular(Values.circle),
        //   // boxShadow: ShadowValues.shadowValuesBlur,
        // ),
        margin: EdgeInsets.symmetric(vertical: Values.circle * .5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 150,
              width: Values.width,
              child: Padding(
                padding: EdgeInsets.all(Values.spacerV),
                child: Image.asset(product.image),
              ),
            ),
            SizedBox(height: Values.spacerV),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                product.name,
                textAlign: TextAlign.center,
                style: StringStyle.textButtom.copyWith(
                  color: ColorApp.blackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
