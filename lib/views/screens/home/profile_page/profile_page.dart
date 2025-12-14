import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/images_url.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import 'package:rayhan_test/views/widgets/common/svg_show.dart';

import '../../../../controllers/storage_controller.dart';
import '../../../../data/models/user_model.dart';
import '../../../../routes/app_routes.dart';
import '../../../../services/api_service.dart';
// import '../../../../services/error_message.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel userModel = UserModel.fromJson(StorageController.getAllData());
    // logger.w(StorageController.getCheckLogin());
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
              InkWell(
                onTap: () => Get.toNamed(AppRoutes.editProfile),
                child: Text(
                  "تعديل بيانات الحساب",
                  style: TextStyle(
                    color: ColorApp.primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    // decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: Values.spacerV),

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
                      onTap: () => Get.toNamed(AppRoutes.myAddressScreen),
                    ),
                    itemWidgetFavorite(),
                    // itemWidget('المفضلة', Icons.favorite_border, onTap: () {}),
                    // itemWidget(
                    //   'القسائم والمكافاَت',
                    //   Icons.card_giftcard_rounded,
                    //   onTap: () {},
                    // ),
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
                      'المساعدة والدعم',
                      CupertinoIcons.person_add,
                      onTap: () {},
                    ),
                    logoutWidget('تسجيل الخروج', Icons.logout),
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

  Widget itemWidgetFavorite() {
    return InkWell(
      borderRadius: BorderRadius.circular(Values.circle * .8),
      onTap: () {
        //
        Get.toNamed(AppRoutes.favoritesScreen);
      },
      child: Container(
        // margin: EdgeInsets.symmetric(vertical: Values.circle),
        padding: EdgeInsets.symmetric(
          horizontal: Values.spacerV,
          vertical: Values.circle * 2,
        ),
        child: Row(
          children: [
            svgImage(
              ImagesUrl.heartBorderIcon,
              hi: 25,
              color: ColorApp.textSecondryColor,
              padingValue: 0,
            ),
            SizedBox(width: Values.spacerV),
            Text(
              'المفضلة',
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

  Widget logoutWidget(String name, IconData icon) {
    return InkWell(
      borderRadius: BorderRadius.circular(Values.circle * .8),
      onTap: () {
        StorageController.removeData();
        ApiService.updateTokenLogin();
        Get.offAllNamed(AppRoutes.login);
      },
      child: Container(
        // margin: EdgeInsets.symmetric(vertical: Values.circle),
        padding: EdgeInsets.symmetric(
          horizontal: Values.spacerV,
          vertical: Values.circle * 2,
        ),
        child: Row(
          children: [
            Icon(icon, color: ColorApp.redColor),
            SizedBox(width: Values.spacerV),
            Text(
              name,
              style: StringStyle.textLabil.copyWith(color: ColorApp.redColor),
            ),
          ],
        ),
      ),
    );
  }
}
