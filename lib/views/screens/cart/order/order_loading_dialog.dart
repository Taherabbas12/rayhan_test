import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';

/// دايلوج انتظار إرسال الطلب
class OrderLoadingDialog extends StatelessWidget {
  final String message;

  const OrderLoadingDialog({
    super.key,
    this.message = 'جاري تنفيذ العملية ...',
  });

  /// عرض الدايلوج
  static void show({String message = 'جاري تنفيذ العملية ...'}) {
    Get.dialog(
      OrderLoadingDialog(message: message),
      barrierDismissible: false,
      barrierColor: Colors.transparent,
    );
  }

  /// إغلاق الدايلوج
  static void hide() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Center(
          child: Container(
            width: Values.width * 0.85,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // أيقونة التحميل SVG
                SvgPicture.asset(
                  'assets/svg/end_loading.svg',
                  width: 120,
                  height: 120,
                ),
                const SizedBox(height: 24),
                // النص
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// شاشة نجاح الطلب
class OrderSuccessDialog extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onGoHome;
  final VoidCallback? onViewOrders;

  const OrderSuccessDialog({
    super.key,
    this.title = 'تم إتمام الطلب',
    this.subtitle,
    this.onGoHome,
    this.onViewOrders,
  });

  /// عرض شاشة النجاح
  static void show({
    String title = 'تم إتمام الطلب',
    String? subtitle,
    VoidCallback? onGoHome,
    VoidCallback? onViewOrders,
  }) {
    Get.dialog(
      OrderSuccessDialog(
        title: title,
        subtitle: subtitle,
        onGoHome: onGoHome,
        onViewOrders: onViewOrders,
      ),
      barrierDismissible: false,
      barrierColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Center(
          child: Container(
            width: Values.width * 0.85,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // أيقونة النجاح SVG
                SvgPicture.asset(
                  'assets/svg/end_loading.svg',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 20),
                // العنوان
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
                const SizedBox(height: 28),
                // زر العودة للصفحة الرئيسية
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onGoHome ?? () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorApp.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'العودة للصفحة الرئيسية',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // زر عرض الطلبات
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: onViewOrders ?? () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: ColorApp.primaryColor),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'عرض طلباتي',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorApp.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
