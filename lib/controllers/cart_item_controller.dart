import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rayhan_test/data/models/user_model.dart';
import 'package:rayhan_test/utils/constants/api_constants.dart';
import '../data/database/cart_db.dart';
import '../data/models/cart_item.dart';
import '../data/models/check_order_response.dart';
import '../data/models/restaurant.dart';
import '../routes/app_routes.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/color_app.dart';
import '../views/screens/cart/order/order_loading_dialog.dart';
import '../views/widgets/message_snak.dart';
import 'home_controller.dart';
import 'home_get_all_controller.dart';
import 'my_address_controller.dart';
import 'storage_controller.dart';

class CartItemController extends GetxController {
  HomeGetAllController homeGetAllController = Get.find<HomeGetAllController>();
  RxList<CartItem> cartItems = <CartItem>[].obs;
  String? currentVendorId;
  CartType? currentCartType;
  Rx<Restaurant?> selectedRestaurant = Rx<Restaurant?>(null);

  RxString orderNote = "".obs;

  final ImagePicker _picker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);
  RxString selectedDay = "".obs;
  RxString selectedTime = "".obs;

  final RxList<File> images = <File>[].obs;
  UserModel userModel = UserModel.fromJson(StorageController.getAllData());

  RxString selectedAddress = ''.obs;

  /// ✅ اختيار مصدر الصورة (كاميرا - معرض - ملفات متعددة)
  Future<void> pickImages(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.green),
                title: const Text("التقاط صورة بالكاميرا"),
                onTap: () async {
                  final picked = await _picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 75,
                  );
                  if (picked != null) images.add(File(picked.path));
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: const Text("اختيار من المعرض"),
                onTap: () async {
                  final pickedFiles = await _picker.pickMultiImage(
                    imageQuality: 75,
                  );
                  if (pickedFiles.isNotEmpty) {
                    images.addAll(pickedFiles.map((e) => File(e.path)));
                  }
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.close, color: Colors.red),
                title: const Text("إلغاء"),
                onTap: () => Get.back(),
              ),
            ],
          ),
        );
      },
    );
  }

  bool validate() {
    if (selectedDay.isEmpty) {
      MessageSnak.message('يرجى اختيار يوم التواجد');
      // ("تنبيه", "", backgroundColor: Colors.red.shade50);
      return false;
    }
    if (selectedTime.isEmpty) {
      MessageSnak.message('يرجى اختيار الوقت');

      // Get.snackbar("تنبيه", "", backgroundColor: Colors.red.shade50);
      return false;
    }

    return true;
  }

  // رفع الصورة
  Future<void> pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) selectedImage.value = File(picked.path);
  }

  void submitOrder() {
    if (!validate()) return;
    Get.toNamed(AppRoutes.orderScreenService);
  }

  List<String> cartType = ['المطاعم', 'المتاجر', 'الماركت', 'الخدمات'];
  List<String> cartServiceType = ['التكسي', 'الخدمات'];
  RxString selectedCartType = 'المطاعم'.obs;
  void onOpenScreenCart() {
    onAddressTypeChanged('المطاعم');
    loadCart();
  }

  void onOpenScreenCartService() {
    onAddressTypeChanged('الخدمات');
  }

  void onAddressTypeChanged(String value) {
    selectedCartType.value = value;
    if (value == 'المطاعم') {
      currentCartType = CartType.restaurant;
    } else if (value == 'المتاجر') {
      currentCartType = CartType.shop;
    } else if (value == 'الماركت') {
      currentCartType = CartType.mart;
    } else if (value == 'الخدمات') {
      currentCartType = CartType.service;
    } else {
      currentCartType = null;
    }
    loadCart(cartType: currentCartType ?? CartType.shop);
    // logger.e('Cart type changed to: $currentCartType');
  }

  @override
  void onInit() {
    super.onInit();
    loadCart(cartType: currentCartType ?? CartType.restaurant);
    // getAddressUser();
  }

  // void getAddressUser() async {
  //   final StateReturnData response = await ApiService.getData(
  //     ApiConstants.tbAddresses,
  //   );

  //   if (response.isStateSucess < 3) {
  //     List<AddressModel> addressList = AddressModel.fromJsonList(response.data);
  //     final userAddresses =
  //         addressList
  //             .where((address) => address.userid == userModel.id.toString())
  //             .toList();

  //     if (userAddresses.isNotEmpty) {
  //       // ✅ أول عنوان يخص المستخدم
  //       final selected = userAddresses.first;
  //       selectedAddress.value = selected.toString();
  //     }
  //   }
  // }

  Future<void> loadCart({CartType cartType = CartType.restaurant}) async {
    final items = await CartDb.instance.getItemsByCartType(
      cartTypeToString(cartType),
    );
    cartItems.assignAll(items);
    if (items.isNotEmpty) {
      currentVendorId = items.first.vendorId;
      currentCartType = items.first.cartType;
    }

    selectedRestaurant.value = await CartDb.instance.getRestaurant(
      cartType.name,
    );
  }

  Future<void> addToCart(
    CartItem newItem, {
    Restaurant? restaurant,
    bool isBack = true,
  }) async {
    logger.e('Adding to cart: 111');
    if (restaurant != null) {
      // if (await CartDb.instance.isRestaurantTypeExists(restaurant.type)) {
      //   MessageSnak.message(
      //     'لا يمكنك خلط أنواع سلة مختلفة',
      //     color: Colors.red,
      //   );
      //   return;
      // }
      if (await CartDb.instance.isRestaurantDifferent(restaurant)) {
        MessageSnak.message(
          'لا يمكنك إضافة منتجات من مورد مختلف',
          color: Colors.red,
        );
        return;
      }
      logger.e(newItem.toMap());
      if (!await CartDb.instance.isRestaurantTypeExists(restaurant.type)) {
        // logger.e(restaurant.toJson());
        await CartDb.instance.saveRestaurant(restaurant);
        selectedRestaurant.value = restaurant;
      }
    }

    final index = cartItems.indexWhere(
      (item) => item.productId == newItem.productId,
    );

    if (index != -1) {
      final existing = cartItems[index];
      await updateItemQuantity(
        existing.productId,
        existing.quantity + newItem.quantity,
      );
    } else {
      await CartDb.instance.insertItem(newItem);
      cartItems.add(newItem);
      currentVendorId ??= newItem.vendorId;
      currentCartType ??= newItem.cartType;
    }

    if (isBack) Get.back();
    MessageSnak.message(
      'تمت إضافة العنصر إلى السلة',
      color: ColorApp.greenColor,
    );
  }

  Future<void> updateItemQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      await deleteItem(productId);
    } else {
      await CartDb.instance.updateQuantity(productId, quantity);
      final index = cartItems.indexWhere((item) => item.productId == productId);
      if (index != -1) {
        final old = cartItems[index];
        cartItems[index] = old.copyWith(quantity: quantity);
      }
    }
  }

  Future<void> deleteItem(String productId) async {
    await CartDb.instance.deleteItem(productId);
    cartItems.removeWhere((item) => item.productId == productId);

    if (cartItems.isEmpty) {
      currentVendorId = null;
      currentCartType = null;
      if (selectedRestaurant.value != null) {
        await CartDb.instance.clearRestaurant(selectedRestaurant.value!.type);
      }
      selectedRestaurant.value = null;
    }
  }

  Future<void> clearCart(String cartType, {String? type}) async {
    await CartDb.instance.clearCart(cartType, type: type);
    if (selectedRestaurant.value != null) {
      await CartDb.instance.clearRestaurant(selectedRestaurant.value!.type);
    }
    cartItems.clear();
    currentVendorId = null;
    currentCartType = null;
    selectedRestaurant.value = null;
  }

  Rx<double> get total => cartItems.fold(
    0.0.obs,
    (sum, item) =>
        sum + (item.price2 > 0 ? item.price2 : item.price1) * item.quantity,
  );
  Rx<int> get countProduct =>
      cartItems.fold(0.obs, (sum, item) => Rx(sum.value + item.quantity));

  // -----------------
  RxBool isLoadingOrder = false.obs;
  RxBool isLoadingCheckOrder = false.obs;
  final TextEditingController noteController = TextEditingController();
  final TextEditingController couponController = TextEditingController();

  // نتيجة التحقق من الطلب
  Rx<CheckOrderResponse?> checkOrderResult = Rx<CheckOrderResponse?>(null);
  RxString couponError = ''.obs;
  RxBool isCouponApplied = false.obs;

  /// التحقق من الطلب والكوبون
  Future<void> checkOrder({String? couponCode}) async {
    if (cartItems.isEmpty) {
      MessageSnak.message('السلة فارغة');
      return;
    }

    isLoadingCheckOrder(true);
    couponError.value = '';

    try {
      Restaurant? restaurant = selectedRestaurant.value;
      final totalPriceValue = total.value;
      final taxValue = (totalPriceValue * 0.05);
      final deliveryPriceValue =
          restaurant?.deliveryPrice ??
          homeGetAllController.deleveryPrice.value.toDouble();

      UserModel userModel = UserModel.fromJson(StorageController.getAllData());
      final controller = Get.find<MyAddressController>();

      final itemsList =
          cartItems.map((item) {
            return {
              "price": (item.price2 > 0 ? item.price2 : item.price1),
              "count": item.quantity,
              "productId": int.tryParse(item.productId) ?? 0,
              "note": item.note,
            };
          }).toList();

      final body = {
        "branch": restaurant != null ? restaurant.id : 0,
        "tax": taxValue,
        "orderPrice": totalPriceValue,
        "userId": userModel.id,
        "coponName": couponCode ?? couponController.text.trim(),
        "addressId": controller.addressSelect.value?.id ?? "",
        "totalPrice": totalPriceValue + taxValue,
        "deliveryPrice": deliveryPriceValue,
        "mainCategoryId": 2,
        "orderType": "Found",
        "orderNote": noteController.text.trim(),
        "items": itemsList,
      };

      final StateReturnData response = await ApiService.postData(
        ApiConstants.checkOrder,
        body,
      );

      if (response.isStateSucess < 3 && response.data != null) {
        checkOrderResult.value = CheckOrderResponse.fromJson(response.data);
        if (couponCode != null && couponCode.isNotEmpty) {
          if (checkOrderResult.value!.hasCouponDiscount) {
            isCouponApplied.value = true;
            MessageSnak.message(
              'تم تطبيق الكوبون بنجاح',
              color: ColorApp.greenColor,
            );
          } else {
            couponError.value = 'الكوبون غير صالح أو لا يوجد خصم';
            isCouponApplied.value = false;
          }
        }
      } else {
        couponError.value = 'فشل التحقق من الطلب';
      }
    } catch (e) {
      couponError.value = 'حدث خطأ: $e';
    } finally {
      isLoadingCheckOrder(false);
    }
  }

  /// إزالة الكوبون
  void removeCoupon() {
    couponController.clear();
    isCouponApplied.value = false;
    couponError.value = '';
    checkOrderResult.value = null;
  }

  Future<void> submitOrderFromCart() async {
    if (cartItems.isEmpty) {
      MessageSnak.message('السلة فارغة أو المطعم غير محدد');
      return;
    }

    // عرض دايلوج التحميل
    OrderLoadingDialog.show(message: 'جاري تنفيذ العملية ...');

    Restaurant? restaurant;
    if (selectedRestaurant.value != null) {
      restaurant = selectedRestaurant.value!;
    }

    final totalPriceValue = total.value;
    final taxValue = (totalPriceValue * 0.05).toStringAsFixed(
      2,
    ); // مثال على ضريبة 5%
    // final orderPriceValue = totalPriceValue.toStringAsFixed(2);
    final deliveryPriceValue =
        selectedRestaurant.value?.deliveryPrice ??
        homeGetAllController.deleveryPrice.value.toDouble();

    final totalWithOutDelivery = totalPriceValue;

    final itemsList =
        cartItems.map((item) {
          return {
            "price": (item.price2 > 0 ? item.price2 : item.price1).toString(),
            "comnt": item.quantity.toString(),
            "prod": item.productId,
            "prodname": item.name,
            "img": item.image,
            "date": DateTime.now().toString(),
            "note": item.note,
            "curncy": '',
            "k1": '',
            "k2": 'false',
          };
        }).toList();

    //  "price": item['price'].toString(),
    //             "comnt": item['count'].toString(),
    //             "prod": item['prod'].toString(),
    //             "prodname": item['prodname'].toString(),
    //             "date": item['date'].toString(),
    //             "curncy": item['curncy'].toString(),
    //             "img": item['img'].toString(),
    //             "k1": item['k1'].toString(),
    //             "k2": item['k2'].toString(),
    //             "note": item['note'].toString(),

    UserModel userModel = UserModel.fromJson(StorageController.getAllData());

    // استخدام نتائج التحقق من الطلب إذا كانت متوفرة
    final finalDeliveryPrice =
        checkOrderResult.value?.newDeliveryPrice ?? deliveryPriceValue;
    final finalTotalPrice =
        checkOrderResult.value?.finalPrice ??
        (totalWithOutDelivery + deliveryPriceValue);
    final appliedCoupon =
        isCouponApplied.value ? couponController.text.trim() : '';
    final couponDiscount = checkOrderResult.value?.coponDiscount ?? 0;

    final body = createOrderBody(
      branchId: restaurant != null ? restaurant.id.toString() : '0',
      tax: taxValue,
      // orderPrice: orderPriceValue,
      userId: userModel.id.toString(),

      total: totalWithOutDelivery.toString(),
      deliveryPrice: finalDeliveryPrice.toString(),

      shopId: restaurant != null ? restaurant.id.toString() : '',
      finalPrice: finalTotalPrice.toString(),

      // orderType: "Found",
      shopType: selectedCartType.value == 'المطاعم' ? "restaurant" : '',
      city: userModel.city ?? '',
      location: '',
      userName: userModel.name,
      userPhone: userModel.phone,
      deviceId: '-----',
      orderNote: noteController.text.trim(),
      items: itemsList,
      promoCode: couponDiscount.toString(),
      promoCodeName: appliedCoupon,
    );
    // .e(body);

    try {
      final StateReturnData response = await ApiService.postData(
        ApiConstants.creatOrder,
        body,
      );

      // logger.e('Order (${selectedCartType.value}) response Data: $body');
      // logger.e('Order response: ${response.data}');
      if (response.isStateSucess < 3) {
        await clearCart(currentCartType!.name, type: restaurant?.type ?? '');

        // إغلاق دايلوج التحميل
        OrderLoadingDialog.hide();

        // عرض شاشة النجاح
        OrderSuccessDialog.show(
          title: 'تم إتمام الطلب',
          onGoHome: () {
            Get.offAllNamed(AppRoutes.home);
          },
          onViewOrders: () {
            Get.offAllNamed(AppRoutes.home);
            // الانتقال لصفحة الطلبات
            Future.delayed(const Duration(milliseconds: 300), () {
              Get.find<HomeController>().changeIndex(1);
            });
          },
        );
      } else {
        OrderLoadingDialog.hide();
        MessageSnak.message('فشل إرسال الطلب');
      }
    } catch (e) {
      OrderLoadingDialog.hide();
      MessageSnak.message('حدث خطأ أثناء إرسال الطلب: $e');
    }
  }

  Future<void> submitOrderServiceFromCart() async {
    if (cartItems.isEmpty) {
      MessageSnak.message('السلة فارغة');
      return;
    }

    // عرض دايلوج التحميل
    OrderLoadingDialog.show(message: 'جاري تنفيذ العملية ...');

    Restaurant? restaurant;
    if (selectedRestaurant.value != null) {
      restaurant = selectedRestaurant.value!;
    }

    final totalPriceValue = total.value;
    final taxValue = (totalPriceValue * 0.05).toStringAsFixed(2);
    final deliveryPriceValue = restaurant?.deliveryPrice ?? 1000;
    final totalWithOutDelivery = totalPriceValue;

    final itemsList =
        cartItems.map((item) {
          return {
            "price": (item.price2 > 0 ? item.price2 : item.price1).toString(),
            "count": item.quantity.toString(),
            "productId": item.productId,
            "note": item.note,
          };
        }).toList();

    UserModel userModel = UserModel.fromJson(StorageController.getAllData());

    final body = createOrderServiceBody(
      branch: '42',
      mainCategoryId: '4',
      orderPrice: (totalWithOutDelivery + deliveryPriceValue).toString(),
      totalPrice: totalWithOutDelivery.toString(),
      deliveryDays: selectedDay.value,
      receiveDays: selectedDay.value,
      deliveryTime: selectedTime.value,
      seenDays: '',
      seenTimes: '',
      images: [],

      tax: taxValue,
      userId: userModel.id.toString(),

      deliveryPrice: deliveryPriceValue.toString(),
      orderNote: noteController.text.trim(),
      items: itemsList,
      // items: [],
    );
    print(body);
    // logger.e(body);
    try {
      final StateReturnData response = await ApiService.postData(
        ApiConstants.createServiceOrder,
        body,
      );

      // logger.e('Order (${selectedCartType.value}) response Data: $body');
      // logger.e('Order response: ${response.data}');
      if (response.isStateSucess < 3) {
        print('clear cart');
        await clearCart(currentCartType!.name, type: restaurant?.type ?? '');
        print('clear cart');

        // إغلاق دايلوج التحميل
        OrderLoadingDialog.hide();

        // عرض شاشة النجاح
        OrderSuccessDialog.show(
          title: 'تم إتمام الطلب',
          onGoHome: () {
            Get.offAllNamed(AppRoutes.home);
          },
          onViewOrders: () {
            Get.offAllNamed(AppRoutes.home);
            Future.delayed(const Duration(milliseconds: 300), () {
              Get.find<HomeController>().changeIndex(1);
            });
          },
        );
      } else {
        OrderLoadingDialog.hide();
        MessageSnak.message('فشل إرسال الطلب');
      }
    } catch (e) {
      OrderLoadingDialog.hide();
      MessageSnak.message('حدث خطأ أثناء إرسال الطلب: $e');
    }
  }
}

Map<String, dynamic> createOrderBody({
  required String userName,
  required String userPhone,
  required String userId,
  required String total,
  required String deliveryPrice,
  required String finalPrice,
  required String tax,
  required String orderNote,

  required String city, // building number
  required String location, // apartment number
  required String shopType,
  required String branchId,
  required String shopId,
  required List<Map<String, dynamic>> items,
  String? promoCode,
  String? promoCodeName,
  String? deviceId,
}) {
  final controller = Get.find<MyAddressController>();

  return {
    "name": userName,
    "phone": userPhone,
    "userx": userId,
    "total": total,
    "status": "new",
    "count": items.length.toString(),
    "note": orderNote,
    "devicesuser": deviceId ?? "",
    "ky1": deliveryPrice,
    "ky2": finalPrice,
    "ky3": promoCode ?? "",
    "ky4": promoCodeName ?? "",
    "date": DateTime.now().toIso8601String(),
    "orderno": DateTime.now().millisecondsSinceEpoch.toString(),
    "tax": tax,
    "addressId": controller.addressSelect.value?.id ?? "",
    "city": city,
    "location": location,
    "shopType": shopType,
    "branch": branchId,
    "shopId": shopId,
    "items": items,
  };
}

Map<String, dynamic> createOrderServiceBody({
  required String branch,
  required String tax,
  required String orderPrice,
  required String userId,

  required String totalPrice,
  required String deliveryPrice,
  required String mainCategoryId,
  String orderType = "Found",
  String deliveryDays = "",
  String receiveDays = "",
  String seenDays = "",
  String deliveryTime = "",
  String receiveTimes = "",
  String seenTimes = "",
  String orderNote = "",
  List? images,
  required List<Map<String, dynamic>> items,
}) {
  final controller = Get.find<MyAddressController>();

  return {
    "branch": '42',
    "tax": tax,
    "orderPrice": orderPrice,
    "userId": userId,
    "addressId": controller.addressSelect.value?.id ?? "",
    "totalPrice": totalPrice,
    "deliveryPrice": deliveryPrice,
    "mainCategoryId": mainCategoryId,
    "orderType": orderType,
    "deliveryDays": deliveryDays,
    "receiveDays": receiveDays,
    "seenDays": seenDays,
    "deliveryTime": deliveryTime,
    "receiveTimes": receiveTimes,
    "seenTimes": seenTimes,
    "orderNote": orderNote,
    "items": items,
    "images":
        images != null
            ? images.map((img) {
              if (img is String) return img;
              if (img.path != null) return img.path;
              return img.toString();
            }).toList()
            : [],
  };
}
