// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/controllers/shops_controller.dart';
import '../../../../data/models/product_model.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/style_app.dart';
import '../../../../utils/constants/values_constant.dart';
import '../../../widgets/more_widgets.dart';
import 'view_shop_product_screen.dart';

class ProductWidgetHorizontal extends StatelessWidget {
  ProductWidgetHorizontal({super.key, required this.product});
  final Product product;
  final ShopsController shopsController = Get.find<ShopsController>();

  RxBool isBasket = false.obs;
  @override
  Widget build(BuildContext context) {
    double discount = 0;
    if (product.price2 != 0) {
      discount = ((product.price1 - product.price2) / product.price1) * 100;
    }

    return InkWell(
      onTap: () => Get.to(() => ViewShopProductScreen(product: product)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ColorApp.borderColor, width: 1),
          borderRadius: BorderRadius.circular(Values.circle),
          // boxShadow: ShadowValues.shadowValuesBlur,
        ),
        height: 130,
        margin: EdgeInsets.symmetric(vertical: Values.circle * .5),
        child: Row(
          children: [
            // SizedBox(
            //   width: Values.width * .3,
            //   height: 130,
            //   child: imageCached(
            //     product.image,
            //     right: true,
            //     boxFit: BoxFit.cover,
            //   ),
            // ),
            SizedBox(
              width: Values.width * .3,
              height: 130,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: 170,
                    width: Values.width,
                    child: imageCached(
                      product.image,
                      top: true,
                      boxFit: BoxFit.cover,
                    ),
                  ),
                  if (product.price2 != 0)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: ColorApp.primaryColor,
                          // borderRadius: BorderRadius.circular(Values.circle),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "الخصم\n%${discount.toStringAsFixed(0)}",
                          style: StringStyle.textTable.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: Values.spacerV * 1.2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Values.circle,
                      vertical: Values.circle * .5,
                    ),
                    child: Text(
                      product.name,
                      style: StringStyle.textButtom.copyWith(
                        color: ColorApp.blackColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Values.circle,
                      vertical: Values.circle * .2,
                    ),
                    child: Text(
                      product.descc,
                      style: StringStyle.textLabilBold.copyWith(
                        color: ColorApp.textSecondryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${product.price2 > 0 ? product.price2 : product.price1} د.ع",
                          style: StringStyle.textLabilBold.copyWith(
                            color: ColorApp.primaryColor,
                          ),
                        ),
                      ),
                      if (product.price2 != 0)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "${product.price1} د.ع",
                            style: StringStyle.textLabilBold.copyWith(
                              color: ColorApp.textSecondryColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      Spacer(),
                      InkWell(
                        onTap: () async {
                          if (isBasket.value) return;
                          isBasket.value = true;

                          // addToCart(product.id, 1, product.price1, product.price2);
                          await Future.delayed(
                            const Duration(milliseconds: 500),
                            () {
                              shopsController.addToCart(
                                product,
                                '',
                                1,
                                isBack: false,
                              );
                            },
                          );

                          isBasket.value = false;
                        },

                        borderRadius: BorderRadius.circular(Values.spacerV),

                        child: Container(
                          // margin: const EdgeInsets.all(2),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(Values.circle),
                          decoration: BoxDecoration(
                            color: ColorApp.primaryColor,
                            borderRadius: BorderRadius.circular(Values.spacerV),
                          ),
                          child: Obx(
                            () =>
                                isBasket.value
                                    ? CupertinoActivityIndicator(
                                      color: ColorApp.backgroundColor,
                                    )
                                    : Text(
                                      "أضف للسلة",
                                      style: StringStyle.textLabilBold.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                          ),
                        ),
                      ),
                      SizedBox(width: Values.spacerV * .5),
                    ],
                  ),
                  SizedBox(height: Values.spacerV * .5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
