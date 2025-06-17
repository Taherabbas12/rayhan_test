// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_item_controller.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/shadow_values.dart';
import '../../../utils/constants/style_app.dart';
import '../../../utils/constants/values_constant.dart';
import '../../widgets/more_widgets.dart';
import 'cart_item_widget.dart';

class RequestRayhan extends StatelessWidget {
  RequestRayhan({super.key});
  CartItemController cartItemController = Get.find<CartItemController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: Values.circle * 2.4),
            decoration: BoxDecoration(
              color: ColorApp.borderColor.withAlpha(50),
              borderRadius: BorderRadius.circular(Values.circle),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                recent(cartItemController.cartType[0]),
                recent(cartItemController.cartType[1]),
                recent(cartItemController.cartType[2]),
              ],
            ),
          ),
          SizedBox(height: Values.spacerV),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: Values.spacerV * 1.3),
            child: Text(
              'المطعم الذي تم تحديد الطلبات منه',
              style: StringStyle.headerStyle.copyWith(
                color: ColorApp.blackColor,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(height: Values.circle),
          // Display selected restaurant if available
          Obx(
            () =>
                cartItemController.selectedRestaurant.value != null
                    ? Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: Values.spacerV,
                        vertical: Values.circle,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorApp.borderColor),
                        color: Color(0xffFAFAFA),
                        borderRadius: BorderRadius.circular(Values.circle),
                        boxShadow: ShadowValues.shadowValues,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 64,
                            height: 64,
                            child: imageCached(
                              cartItemController.selectedRestaurant.value!.logo,
                              right: true,
                            ),
                          ),
                          SizedBox(width: Values.spacerV),
                          Text(
                            cartItemController.selectedRestaurant.value!.name,
                            style: StringStyle.textLabil.copyWith(
                              color: ColorApp.blackColor,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    )
                    : Container(),
          ),

          buildCartItems(),
        ],
      ),
    );
  }

  // items in the cart
  Widget buildCartItems() {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          itemCount: cartItemController.cartItems.length,
          itemBuilder: (context, index) {
            final item = cartItemController.cartItems[index];
            return CartItemWidget(
              item: item,
              onDelete: () => cartItemController.deleteItem(item.productId),
              onIncrease: () {
                cartItemController.updateItemQuantity(
                  item.productId,
                  item.quantity + 1,
                );
              },
              onDecrease: () {
                cartItemController.updateItemQuantity(
                  item.productId,
                  item.quantity - 1,
                );
              },
            );

            //  ListTile(
            //   title: Text(item.name),
            //   subtitle: Text('Quantity: ${item.quantity}'),
            //   trailing: Text('${item.price} \$'),
            // );
          },
        ),
      ),
    );
  }

  Widget recent(String title) {
    return Expanded(
      child: InkWell(
        onTap: () => cartItemController.onAddressTypeChanged(title),
        child: Obx(
          () => Container(
            alignment: Alignment.center,
            height: 35,
            decoration: BoxDecoration(
              color:
                  cartItemController.selectedCartType.value == title
                      ? ColorApp.primaryColor
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(Values.circle),
            ),
            child: Text(
              title,
              style: StringStyle.textLabil.copyWith(
                color:
                    cartItemController.selectedCartType.value != title
                        ? ColorApp.backgroundColorContent
                        : ColorApp.whiteColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
