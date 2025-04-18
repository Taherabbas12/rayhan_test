// ignore_for_file: must_be_immutable

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routes/app_routes.dart';
import 'utils/constants/color_app.dart';
import 'utils/constants/style_app.dart';
import 'utils/constants/values_constant.dart';

// import 'app/services/update_cureent.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // DevicePreview(
    // enabled: true, // اضبطها على true لتفعيل المعاينة
    // builder: (context) =>
    MyApp(), // استبدل MyApp باسم تطبيقك
    // )
  );

  // debugPrint("🐛 هذه رسالة debugPrint");
  // FlutterError.reportError(
  //     FlutterErrorDetails(exception: Exception("🔥 خطأ في التطبيق!")));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // تخزين حجم الشاشه للاستخدام في كل التبطيق
    // في واجهات اخرى
    Values.width = MediaQuery.sizeOf(context).width;
    Values.height = MediaQuery.sizeOf(context).height;
    return
    //  ScreenUtilInit(
    //   designSize: Size(
    //     Values.width,
    //     Values.height,
    //   ), // حجم التصميم (عرض × ارتفاع)
    //   minTextAdapt: true,
    //   splitScreenMode: true,
    //   builder: (context, child) {
    //     return
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.cairoTextTheme(),
        // textTheme: GoogleFonts.readexProTextTheme(),
        fontFamily: 'Noto Kufi Arabic',
        scaffoldBackgroundColor: ColorApp.backgroundColor,
        appBarTheme: AppBarTheme(
          surfaceTintColor: ColorApp.backgroundColor,
          backgroundColor: ColorApp.backgroundColor,
          titleTextStyle: StringStyle.headerStyle,
          centerTitle: true,
        ),
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: ColorApp.primaryColor,
        ),
      ),
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        // احسب معامل التحجيم بناءً على عرض الشاشة
        double textScaleFactor = mediaQuery.size.width / 400;

        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: TextScaler.linear(textScaleFactor.clamp(0.8, 0.9)),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          ),
        );
      },
      title: 'ريحان',
      // initialRoute: StorageController.checkLoginStatus()
      //     ? AppRoutes.home
      //     : AppRoutes.login,
      initialRoute: AppRoutes.resturantsScreen,
      getPages: AppRoutes.routes,
    );
  }
}
