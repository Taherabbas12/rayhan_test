import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/style_app.dart';
import '../../../utils/constants/values_constant.dart';

class GuestProfilePage extends StatelessWidget {
  const GuestProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Values.spacerV * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: Values.spacerV * 6,
                color: ColorApp.primaryColor,
              ),
              SizedBox(height: Values.spacerV * 2),
              Text('أنت غير مسجّل دخول', style: StringStyle.titleApp),
              SizedBox(height: Values.spacerV),
              Text(
                'سجّل دخولك أو أنشئ حساباً جديداً للاستفادة من جميع مزايا التطبيق، مثل إدارة الطلبات، عناوين التوصيل، والمفضلة.',
                textAlign: TextAlign.center,
                style: StringStyle.textLabil.copyWith(
                  color: ColorApp.textSecondryColor.withAlpha(180),
                ),
              ),
              SizedBox(height: Values.spacerV * 3),

              /// زر تسجيل الدخول
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(AppRoutes.login),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorApp.primaryColor,
                    padding: EdgeInsets.symmetric(
                      vertical: Values.spacerV * 1.2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Values.circle),
                    ),
                  ),
                  child: Text(
                    'تسجيل الدخول',
                    style: StringStyle.textButtom.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              SizedBox(height: Values.spacerV * 1.5),

              /// زر إنشاء حساب جديد
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Get.toNamed(AppRoutes.login),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: Values.spacerV * 1.2,
                    ),
                    side: BorderSide(color: ColorApp.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Values.circle),
                    ),
                  ),
                  child: Text(
                    'إنشاء حساب جديد',
                    style: StringStyle.textButtom.copyWith(
                      color: ColorApp.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
