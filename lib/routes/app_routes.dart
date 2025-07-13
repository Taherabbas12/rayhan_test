import 'package:get/get.dart';

import '../bindings/auth_binding.dart';

import '../bindings/cart_item_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/market_binding.dart';
import '../bindings/market_product_binding.dart';
import '../bindings/restaurant_binding.dart';
import '../bindings/services_binding.dart';
import '../bindings/shop_binding.dart';
import '../bindings/taxi_binding.dart';
import '../views/screens/auth/login.dart';
import '../views/screens/auth/otp.dart';
import '../views/screens/auth/register.dart';
import '../views/screens/auth/register_complete.dart';
import '../views/screens/cart/cart_item_screen.dart';
import '../views/screens/home/home_screen.dart';
import '../views/screens/market/market_screen.dart';
import '../views/screens/market/view_category_details/category_details_screen.dart';
import '../views/screens/notification/notification_screen.dart';
import '../views/screens/order/order_screen.dart';
import '../views/screens/restaurants/resturants_screen.dart';
import '../views/screens/restaurants/restaurant/shop_screen.dart';
import '../views/screens/services/services_screen.dart';
import '../views/screens/services/taxi/taxi_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/Register';
  static const registerComplete = '/Register-Complete';
  static const otp = '/otp';
  static const resturantsScreen = '/Resturants-Screen';
  static const servicesScreen = '/Services-Screen';
  static const home = '/Home-Screen';
  static const shopScreen = '/Shop-Screen';
  static const marketScreen = '/Market-Screen';
  static const categoryDetailsScreen = '/Category-Details-Screen';
  static const notificationScreen = '/Notification-Screen';
  static const taxiScreen = '/Taxi-Screen';
  static const cartItemScreen = '/Cart-Item-Screen';
  static const orderScreen = '/Order-Screen';

  static final routes = [
    GetPage(
      name: cartItemScreen,
      page: () => CartItemScreen(),
      binding: CartItemBinding(),
    ),
    GetPage(name: login, page: () => Login(), binding: LoginBinding()),
    GetPage(name: register, page: () => Register(), binding: LoginBinding()),
    GetPage(
      name: registerComplete,
      page: () => RegisterComplete(),
      binding: LoginBinding(),
    ),
    GetPage(name: otp, page: () => OTPScreen(), binding: LoginBinding()),
    GetPage(name: home, page: () => HomeScreen(), binding: HomeBinding()),
    GetPage(name: shopScreen, page: () => ShopScreen(), binding: ShopBinding()),
    GetPage(name: notificationScreen, page: () => NotificationScreen()),
    GetPage(name: taxiScreen, page: () => TaxiScreen(), binding: TaxiBinding()),
    GetPage(
      name: categoryDetailsScreen,
      page: () => CategoryDetailsScreen(),
      binding: MarketProductBinding(),
    ),
    GetPage(
      name: marketScreen,
      page: () => MarketScreen(),
      binding: MarketBinding(),
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
    GetPage(name: orderScreen, page: () => OrderScreen()),
  ];
}
