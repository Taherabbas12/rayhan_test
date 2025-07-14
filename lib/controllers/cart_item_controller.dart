import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/database/cart_db.dart';
import '../data/models/cart_item.dart';
import '../data/models/restaurant.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/color_app.dart';
import '../views/widgets/message_snak.dart';

class CartItemController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;
  String? currentVendorId;
  CartType? currentCartType;
  Rx<Restaurant?> selectedRestaurant = Rx<Restaurant?>(null);

  List<String> cartType = ['المطاعم', 'المتاجر', 'الماركت'];
  RxString selectedCartType = 'المطاعم'.obs;

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
    loadCart(cartType: currentCartType ?? CartType.restaurant);
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

    selectedRestaurant.value = await CartDb.instance.getRestaurant();
  }

  Future<void> addToCart(
    CartItem newItem, {
    Restaurant? restaurant,
    bool isBack = true,
  }) async {
    if (newItem.cartType == CartType.restaurant) {
      if (currentCartType != null && currentCartType != newItem.cartType) {
        MessageSnak.message('لا يمكنك خلط أنواع سلة مختلفة');
        return;
      }

      if (currentVendorId != null && currentVendorId != newItem.vendorId) {
        MessageSnak.message('لا يمكنك إضافة منتجات من مورد مختلف');

        return;
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

    if (selectedRestaurant.value == null && restaurant != null) {
      await CartDb.instance.saveRestaurant(restaurant);
      selectedRestaurant.value = restaurant;
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
      selectedRestaurant.value = null;
      await CartDb.instance.clearRestaurant();
    }
  }

  Future<void> clearCart() async {
    await CartDb.instance.clearCart();
    await CartDb.instance.clearRestaurant();
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
    if (cartItems.isEmpty || selectedRestaurant.value == null) {
      MessageSnak.message('السلة فارغة أو المطعم غير محدد');
      return;
    }
    isLoadingOrder(true);

    final restaurant = selectedRestaurant.value!;
    final totalPriceValue = total.value;
    final taxValue = (totalPriceValue * 0.05).toStringAsFixed(
      2,
    ); // مثال على ضريبة 5%
    final orderPriceValue = totalPriceValue.toStringAsFixed(2);
    final deliveryPriceValue = restaurant.deliveryPrice.toStringAsFixed(2);
    final totalWithDelivery = (totalPriceValue + restaurant.deliveryPrice)
        .toStringAsFixed(2);

    final itemsList =
        cartItems.map((item) {
          return {
            "price": (item.price2 > 0 ? item.price2 : item.price1).toString(),
            "count": item.quantity.toString(),
            "productId": item.productId,
            "note": item.note,
          };
        }).toList();

    final body = createOrderBody(
      branchId: restaurant.id.toString(),
      taxPrice: taxValue,
      orderPrice: orderPriceValue,
      userId: '1087', // يجب استبداله بمعرف المستخدم الفعلي
      addressId: 'addressid',
      totalPrice: totalWithDelivery,
      deliveryPrice: deliveryPriceValue,
      mainCategoryId: restaurant.categoryId,
      orderType: "Found",
      deliveryDaySelected:
          DateTime.now().toIso8601String(), // مثال على تاريخ التسليم
      receiveDaySelected: DateTime.now().toIso8601String(),
      seenDaySelected: DateTime.now().toIso8601String(),
      deliveryTimeSelected: DateTime.now().toIso8601String(),
      receiveTimeSelected: DateTime.now().toIso8601String(),
      seenTimeSelected: DateTime.now().toIso8601String(),
      orderNote: noteController.text.trim(),
      items: itemsList,
    );

    try {
      final StateReturnData response = await ApiService.postData(
        ApiConstants.marketCatagorys,
        body,
      );
      logger.e('Order response: ${response.data}');
      if (response.isStateSucess < 3) {
        Get.back();
        Get.back();
        MessageSnak.message('تم إرسال الطلب بنجاح', color: ColorApp.greenColor);
        await clearCart(); // إفراغ السلة بعد الإرسال الناجح
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
  required String branchId,
  required String taxPrice,
  required String orderPrice,
  required String userId,
  required String addressId,
  required String totalPrice,
  required String deliveryPrice,
  required String mainCategoryId,
  required String orderType,
  required String deliveryDaySelected,
  required String receiveDaySelected,
  String? seenDaySelected,
  required String deliveryTimeSelected,
  required String receiveTimeSelected,
  String? seenTimeSelected,
  required String orderNote,
  required List<Map<String, dynamic>> items,
}) {
  return {
    "branch": branchId,
    "tax": taxPrice,
    "orderPrice": orderPrice,
    "userId": userId,
    "addressId": addressId,
    "totalPrice": totalPrice,
    "deliveryPrice": deliveryPrice,
    "mainCategoryId": mainCategoryId,
    "orderType": orderType,
    "deliveryDays": deliveryDaySelected,
    "receiveDays": receiveDaySelected,
    if (seenDaySelected != null) "seenDays": seenDaySelected,
    "deliveryTime": deliveryTimeSelected.toString(),
    "receiveTimes": receiveTimeSelected.toString(),
    "seenTimes": seenTimeSelected == null ? "" : seenTimeSelected.toString(),
    "orderNote": orderNote,
    "items":
        items.map((item) {
          return {
            "price": item['price'].toString(),
            "count": item['count'].toString(),
            "productId": item['productId'].toString(),
            "note": item['note'].toString(),
          };
        }).toList(),
  };
}
