import 'package:get/get.dart';

import '../bindings/auth_binding.dart';

import '../bindings/restaurant_binding.dart';
import '../bindings/services_binding.dart';
import '../bindings/shop_binding.dart';
import '../views/screens/auth/login.dart';
import '../views/screens/auth/otp.dart';
import '../views/screens/restaurants/resturants_screen.dart';
import '../views/screens/restaurants/shop/shop_screen.dart';
import '../views/screens/services/services_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/Register';
  static const otp = '/otp';
  static const resturantsScreen = '/Resturants-Screen';
  static const servicesScreen = '/Services-Screen';
  static const home = '/Home-Screen';
  static const shopScreen = '/Shop-Screen';

  static final routes = [
    GetPage(name: login, page: () => Login(), binding: LoginBinding()),
    // GetPage(name: register, page: () => Register(), binding: LoginBinding()),
    GetPage(name: otp, page: () => OTPScreen(), binding: LoginBinding()),
    GetPage(
      name: shopScreen,
      page: () => ShopScreen(),
      binding: ShopBinding(),
    ),
    // GetPage(
    //   name: rePassword,
    //   page: () => RePassword(),
    //   binding: LoginBinding(),
    // ),
    GetPage(
      name: resturantsScreen,
      page: () => ResturantsScreen(),
      binding: RestaurantBinding(),
    ),
    GetPage(
      name: servicesScreen,
      page: () => ServicesScreen(),
      binding: ServicesBinding(),
    ),
  ];
}
