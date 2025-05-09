import 'package:flutter/material.dart';

import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/images_url.dart';
import '../../../utils/constants/values_constant.dart';
import '../../widgets/actions_button.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: Values.spacerV),
          child: Image.asset(ImagesUrl.imageHome),
        ),
        Padding(
          padding: EdgeInsets.only(top: Values.spacerV),
          child: Row(
            children: [
              Spacer(),
              BottonsC.actionIconWithOutColor(
                Icons.shopping_cart_outlined,
                colorBorder: ColorApp.borderColor,
                size: 25,
                colorBackgraond: Colors.transparent,
                circle: Values.circle,
                color: ColorApp.primaryColor,
                'السلة',
                () {},
              ),
              SizedBox(width: Values.circle),
              BottonsC.actionIconWithOutColor(
                Icons.notifications_none_sharp,
                colorBorder: ColorApp.borderColor,
                size: 25,
                colorBackgraond: Colors.transparent,
                circle: Values.circle,
                color: ColorApp.primaryColor,
                'الاشعارات',
                () {},
              ),

              SizedBox(width: Values.spacerV),
            ],
          ),
        ),
      ],
    );
  }
}
