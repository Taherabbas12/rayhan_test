import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/data/models/user_model.dart';
import 'package:rayhan_test/utils/constants/api_constants.dart';
import '../data/database/cart_db.dart';
import '../data/models/cart_item.dart';
import '../data/models/restaurant.dart';
import '../routes/app_routes.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/color_app.dart';
import '../views/widgets/message_snak.dart';
import 'storage_controller.dart';

class CartItemController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;
  String? currentVendorId;
  CartType? currentCartType;
  Rx<Restaurant?> selectedRestaurant = Rx<Restaurant?>(null);

  List<String> cartType = ['المطاعم', 'المتاجر', 'الماركت'];
  RxString selectedCartType = 'المطاعم'.obs;
  void onOpenScreenCart() {
    onAddressTypeChanged('المطاعم');
    loadCart();
  }

  void onAddressTypeChanged(String value) {
    selectedCartType.value = value;
    if (value == 'المطاعم') {
      currentCartType = CartType.restaurant;
    } else if (value == 'المتاجر') {
      currentCartType = CartType.shop;
    } else if (value == 'الماركت') {
      currentCartType = CartType.mart;
    } else {
      currentCartType = null;
    }
    loadCart(cartType: currentCartType ?? CartType.shop);
    logger.e('Cart type changed to: $currentCartType');
  }

  @override
  void onInit() {
    super.onInit();
    loadCart(cartType: currentCartType ?? CartType.restaurant);
  }

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
    if (restaurant != null) {
      // if (await CartDb.instance.isRestaurantTypeExists(restaurant.type)) {
      //   MessageSnak.message(
      //     '❗ لا يمكنك خلط أنواع سلة مختلفة',
      //     color: Colors.red
      //   );
      //   return;
      // }
      if (await CartDb.instance.isRestaurantDifferent(restaurant)) {
        MessageSnak.message(
          '❗ لا يمكنك إضافة منتجات من مورد مختلف',
          color: Colors.red,
        );
        return;
      }
      if (!await CartDb.instance.isRestaurantTypeExists(restaurant.type)) {
        logger.e(restaurant.toJson());
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
    await CartDb.instance.clearRestaurant(selectedRestaurant.value!.type);
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
  final TextEditingController noteController = TextEditingController();
  final TextEditingController couponController = TextEditingController();

  Future<void> submitOrderFromCart() async {
    if (cartItems.isEmpty) {
      MessageSnak.message('السلة فارغة أو المطعم غير محدد');
      return;
    }
    isLoadingOrder(true);
    Restaurant? restaurant;
    if (selectedRestaurant.value != null) {
      restaurant = selectedRestaurant.value!;
    }

    final totalPriceValue = total.value;
    final taxValue = (totalPriceValue * 0.05).toStringAsFixed(
      2,
    ); // مثال على ضريبة 5%
    // final orderPriceValue = totalPriceValue.toStringAsFixed(2);
    final deliveryPriceValue = restaurant?.deliveryPrice ?? 500;
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

    final body = createOrderBody(
      branchId: restaurant != null ? restaurant.id.toString() : '',
      tax: taxValue,
      // orderPrice: orderPriceValue,
      userId: userModel.id.toString(),
      addressId: userModel.addressid,
      total: totalWithOutDelivery.toString(),
      deliveryPrice: deliveryPriceValue.toString(),

      shopId: restaurant != null ? restaurant.id.toString() : '',
      finalPrice: (totalWithOutDelivery + deliveryPriceValue).toString(),

      // orderType: "Found",
      shopType: selectedCartType.value == 'المطاعم' ? "restaurant" : '',
      city: userModel.city ?? '',
      location: '',
      userName: userModel.name,
      userPhone: userModel.phone,
      deviceId: '-----',
      orderNote: noteController.text.trim(),
      items: itemsList,
      promoCode: '',
      promoCodeName: '',
    );

    try {
      final StateReturnData response = await ApiService.postData(
        ApiConstants.creatOrder,
        body,
      );

      logger.e('Order (${selectedCartType.value}) response Data: $body');
      logger.e('Order response: ${response.data}');
      if (response.isStateSucess < 3) {
        await clearCart(currentCartType!.name, type: restaurant?.type ?? '');

        Get.offAllNamed(AppRoutes.home);

        MessageSnak.message('تم إرسال الطلب بنجاح', color: ColorApp.greenColor);
      } else {
        MessageSnak.message('فشل إرسال الطلب');
      }
    } catch (e) {
      MessageSnak.message('حدث خطأ أثناء إرسال الطلب: $e');
    } finally {
      isLoadingOrder(false);
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
  required String addressId,
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
    "addressId": addressId,
    "city": city,
    "location": location,
    "shopType": shopType,
    "branch": branchId,
    "shopId": shopId,
    "items": items,
  };
}
