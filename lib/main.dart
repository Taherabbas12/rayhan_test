// ignore_for_file: must_be_immutable

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_secure_storage/get_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controllers/storage_controller.dart';
import 'routes/app_routes.dart';
import 'utils/constants/color_app.dart';
import 'utils/constants/style_app.dart';
import 'utils/constants/values_constant.dart';

// import 'app/services/update_cureent.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await GetSecureStorage.init(
    password: Values.passwordStorage,
    container: Values.pathContiner,
  );

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
          titleTextStyle: StringStyle.titleApp,
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
      initialRoute:
          StorageController.checkLoginStatus()
              ? AppRoutes.home
              : AppRoutes.login,
      // initialRoute: AppRoutes.register,
      getPages: AppRoutes.routes,
    );
  }
}


// https://gateway.standingtech.com/api/v4/sms/send
// {
// "recipient":"964$phoneNumber",
// "sender
// _id":"Rayhan",
// "type":"whatsapp",
// "message": randomSixDigitNumber.toString(),
// "lang":"ar"
// }
// Service 

// Method : get 
// https://rayhan.shop/api/ServiceMainCategory
// Get main categories like : تكسي ، مكوى غسل .. 
// ———————————————
// Create taxi order 
// Method : post
// https://rayhan.shop/api/TaxiOrders
// Body : {
//   "from": "${addressModel!.buildingNo}|${addressModel!.blockNo}",
//   "to": toPosition.text,
//   "status": "new",
//   "fromLat": value.lat.toString(),
//   "toLat": '0',
//   "fromLong": value.lang.toString(),
//   "toLong": '0',
//   "userId": value.user!.id.toString(),
//   "userPhone": value.user!.phone.toString(),
//   "userNote": "string",
//   "driverNote": "string",
//   "publicNote": "string",
//   "type": "taxi",
// }
 
// ——————————————

// Method: get
// https://rayhan.shop/api/ServiceProvider/ByMainCategory?id=categoryId
// Get service provider details

// ——————————————

// Method: get
// https://rayhan.shop/api/ServiceSubCategory/ByMainCategory?id=categoryId
// Get subCategory of main category for service


// ——————————————
// Method: post 
// https://rayhan.shop/api/ServiceProduct/BySubCategory?pageSize=$pageSize&page=$page&categoryId=$category&userType=customer
// $category equal subcategory id not category id
// Get product by sub category 

// ————————————————
// Create service order with selected product 
// Method : post
// https://rayhan.shop/api/ServiceOrder/CreateServiceOrder
// Header : "content-type": "application/json"
// Body : 
// {
//   "branch": controller.cartsService.first['shop'].id.toString(),
//   "tax": taxPrice.toString(),
//   "orderPrice": orderPrice.toString(),
//   "userId": controller.user!.id.toString(),
//   "addressId": addressId.toString(),
//   "totalPrice": totalPrice.toString(),
//   "deliveryPrice": newDeliveryPrice.toString(),
//   "mainCategoryId": controller.cartsService.first['shop'].mainCategoryId.toString(),
//   "orderType": "Found",
//   "deliveryDays": setDayFormat(deliveryDaySelected.toString()).toString(),
//   "receiveDays": setDayFormat(receiveDaySelected.toString()).toString(),
//   // "seenDays": setDayFormat(seenDaySelected.toString()).toString(),
//   "deliveryTime": formatTimeRange(deliveryTimeSelected!).toString(),
//   "receiveTimes": formatTimeRange(receiveTimeSelected!).toString(),
//   "seenTimes": seenTimeSelected == null ? "" : formatTimeRange(seenTimeSelected!).toString(),
//   "orderNote": orderNote.text,

//   "items": items.map((item) {
//     return {
//     "price": item['price'].toString(),
//     "count": item['count'].toString(),
//     "productId": item['productId'].toString(),
//     "note": item['note'].toString(),
//     };
//   }).toList()
// }


// ————————————————
// Create service order with out selected product 
// Method : post
// https://rayhan.shop/api/ServiceOrder/CreateServiceOrder
// Header : "content-type": "application/json"
// {
//   "branch": provider.id.toString(),
//   "tax": taxPrice.toString(),
//   "orderPrice": orderPrice.toString(),
//   "userId": controller.user!.id.toString(),
//   "addressId": addressId.toString(),
//   "totalPrice": totalPrice.toString(),
//   "deliveryPrice": newDeliveryPrice.toString(),
//   "mainCategoryId": provider.mainCategoryId.toString(),
//   "orderType": "NotFound",
//   "deliveryDays": "",
//   "receiveDays": "",
//   "seenDays": setDayFormat(seenDaySelected.toString()).toString(),
//   "deliveryTime": "",
//   "receiveTimes": "",
//   "seenTimes": formatTimeRange(seenTimeSelected!).toString(),
//   "orderNote": orderNote.text,
//   "images": images.map((item) {
//     return {
//       "image": item.toString(),
//     };
//   }).toList(),
//   "items": []
// }


// عند انشاء طلب خدمه يجب توفر اوقات و ايام التواجد و الاستلام و تحديد الاسعار 
// يرجى مراجعه كل من setDaysAndTimes  & setTotalPrice في => getFolder/ServiceCheckOutController
// لتحديد الاوقات و الايام و السعر