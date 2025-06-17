// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_item_controller.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/style_app.dart';
import '../../../utils/constants/values_constant.dart';
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
          SizedBox(height: Values.circle),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Values.spacerV * 1.3,
              vertical: Values.spacerV,
            ),
            child: Text(
              'المطعم الذي تم تحديد الطلبات منه',
              style: StringStyle.headerStyle.copyWith(
                color: ColorApp.blackColor,
              ),
              textAlign: TextAlign.right,
            ),
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
              onDelete: () => cartItemController.cartItems.remove(item),
              onIncrease: () => {},
              onDecrease: () => {},
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
