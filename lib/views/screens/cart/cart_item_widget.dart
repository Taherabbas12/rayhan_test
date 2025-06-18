// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:rayhan_test/utils/constants/shadow_values.dart';
import 'package:rayhan_test/views/widgets/more_widgets.dart';

import '../../../data/models/cart_item.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/style_app.dart';
import '../../../utils/constants/values_constant.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onDelete;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    double discount = 0;
    if (item.price2 != 0) {
      discount = ((item.price1 - item.price2) / item.price1) * 100;
    }
    return Container(
      // height: item.note.isNotEmpty ? 150 : 130,
      constraints: BoxConstraints(
        minHeight: item.note.isNotEmpty ? 160 : 130,
        maxHeight: item.note.isNotEmpty ? 170 : 160,
      ),
      padding: EdgeInsets.symmetric(
        vertical: Values.circle,
        horizontal: Values.spacerV,
      ),
      child: Dismissible(
        key: Key(item.id.toString()),
        direction: DismissDirection.startToEnd,
        background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.3),
            borderRadius: BorderRadius.circular(Values.circle),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
        confirmDismiss: (_) async {
          onDelete();
          return true;
        },
        child: Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Values.circle),
            border: Border.all(color: ColorApp.borderColor),
            boxShadow: ShadowValues.shadowValues2,
          ),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: 130,
                    height: 130,
                    child: imageCached(item.image, right: true),
                  ),

                  if (item.price2 != 0)
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

              SizedBox(width: Values.circle),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    SizedBox(height: 5),
                    Text(
                      item.name,
                      style: StringStyle.textButtom.copyWith(
                        color: ColorApp.blackColor,
                      ),
                    ),

                    if (item.note.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        'الملاحظة: ${item.note}',
                        maxLines: 2,
                        style: StringStyle.textLabil.copyWith(
                          color: ColorApp.subColor,
                          fontSize: 14,
                        ),
                      ),
                    ],

                    const SizedBox(height: 8),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Row(
                          children: [
                            Text(
                              '${(item.price2 > 0 ? item.price2 : item.price1).toStringAsFixed(0)} د.ع',
                              style: StringStyle.textLabil.copyWith(
                                color: ColorApp.primaryColor,
                              ),
                            ),
                            if (item.price2 > 0) SizedBox(width: Values.circle),
                            if (item.price2 > 0)
                              Text(
                                '${item.price1.toStringAsFixed(0)} د.ع',
                                style: StringStyle.textTable.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                              ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: onDecrease,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: ColorApp.primaryColor.withOpacity(
                                      0.1,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.remove,
                                    color: ColorApp.primaryColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Values.circle,
                                ),
                                child: Text(
                                  item.quantity.toString(),
                                  style: StringStyle.textLabil,
                                ),
                              ),
                              InkWell(
                                onTap: onIncrease,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: ColorApp.primaryColor.withOpacity(
                                      0.1,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: ColorApp.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Values.circle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
