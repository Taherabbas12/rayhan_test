import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';

import '../../../../controllers/storage_controller.dart';
import '../../../../data/models/user_model.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel userModel = UserModel.fromJson(StorageController.getAllData());

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Values.spacerV * 2),
          child: Column(
            children: [
              SizedBox(height: Values.spacerV * 2),
              Text('الحساب', style: StringStyle.titleApp),
              SizedBox(height: Values.spacerV * 2),
              CircleAvatar(
                backgroundColor: ColorApp.primaryColor,
                radius: Values.spacerV * 4,
                child: Icon(Icons.person, size: Values.spacerV * 4),
              ),
              SizedBox(height: Values.spacerV * 2),
              Text(userModel.name, style: StringStyle.titleApp),
              Text(
                userModel.phone,
                style: StringStyle.textLabil.copyWith(
                  color: ColorApp.textSecondryColor.withAlpha(150),
                ),
              ),
              SizedBox(height: Values.circle * 2.4),

              Container(
                // margin: EdgeInsets.symmetric( ),
                // padding: EdgeInsets.symmetric(vertical: Values.spacerV),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Values.circle),
                  border: Border.all(color: ColorApp.borderColor),
                ),
                child: Column(
                  children: [
                    itemWidget(
                      'عناويني',
                      Icons.location_on_outlined,
                      onTap: () {},
                    ),
                    itemWidget('المفضلة', Icons.favorite_border, onTap: () {}),
                    itemWidget(
                      'القسائم والمكافاَت',
                      Icons.card_giftcard_rounded,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: Values.circle * 2.4),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: Values.spacerV * 2),
                // padding: EdgeInsets.symmetric(vertical: Values.spacerV),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Values.circle),
                  border: Border.all(color: ColorApp.borderColor),
                ),
                child: Column(
                  children: [
                    itemWidget(
                      'اعمل معنا',
                      CupertinoIcons.person_add,
                      onTap: () {},
                    ),
                    itemWidget(
                      'تقييم التطبيق على المتجر',
                      Icons.star_border,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemWidget(String name, IconData icon, {void Function()? onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(Values.circle * .8),
      onTap: onTap,
      child: Container(
        // margin: EdgeInsets.symmetric(vertical: Values.circle),
        padding: EdgeInsets.symmetric(
          horizontal: Values.spacerV,
          vertical: Values.circle * 2,
        ),
        child: Row(
          children: [
            Icon(icon, color: ColorApp.textSecondryColor),
            SizedBox(width: Values.spacerV),
            Text(
              name,
              style: StringStyle.textLabil.copyWith(
                color: ColorApp.textSecondryColor,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, color: ColorApp.textSecondryColor),
          ],
        ),
      ),
    );
  }
}
