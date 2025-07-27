import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rayhan_test/utils/constants/images_url.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import 'package:rayhan_test/views/widgets/common/svg_show.dart';
import 'package:rayhan_test/views/widgets/more_widgets.dart';

import '../../../../data/models/order_model.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';

class RequestWidget extends StatelessWidget {
  const RequestWidget({super.key, required this.orderModel});
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Values.spacerV),
      padding: EdgeInsets.all(Values.spacerV),
      decoration: BoxDecoration(
        border: Border.all(color: ColorApp.borderColor),
        borderRadius: BorderRadius.circular(Values.circle),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(Values.circle * .2),
            decoration: BoxDecoration(
              border: Border.all(color: ColorApp.borderColor),
              borderRadius: BorderRadius.circular(Values.circle),
            ),
            height: 80,
            width: 80,
            child: imageCached(
              orderModel.image ?? 'url',
              circle: Values.circle,
              left: true,
              down: true,
              right: true,
              top: true,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Values.circle),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      svgImage(
                        ImagesUrl.infoSquareIcon,
                        padingValue: Values.circle * .5,
                      ),
                      Text('حالة الطلب : ', style: StringStyle.textLabilBold),
                      Text(
                        orderModel.status!,
                        style: StringStyle.textLabilBold.copyWith(
                          color: ColorApp.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    orderModel.shopName!,
                    style: StringStyle.textButtom.copyWith(
                      color: ColorApp.blackColor,
                    ),
                  ),
                  SizedBox(height: Values.circle * .5),
                  Wrap(
                    children: [
                      svgImage(
                        ImagesUrl.ticketIcon,
                        padingValue: Values.circle * .5,
                        hi: 15,
                      ),
                      Text('رقم العملية : ', style: StringStyle.textLabilBold),
                      Text(
                        '${orderModel.orderNo}#',
                        style: StringStyle.textLabilBold.copyWith(
                          color: Color(0xff0CC25F),
                        ),
                      ),
                      Row(
                        children: [
                          svgImage(
                            ImagesUrl.copperDiamondFillIcon,
                            padingValue: Values.circle * .5,
                            hi: 15,
                          ),
                          Text(
                            '${formatCurrency(orderModel.finalPrice!)} د.ع',
                            style: StringStyle.textLabilBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
