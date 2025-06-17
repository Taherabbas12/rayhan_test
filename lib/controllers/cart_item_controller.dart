import 'package:get/get.dart';
import '../data/database/cart_db.dart';
import '../data/models/cart_item.dart';
import '../data/models/restaurant.dart';

class CartItemController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;
  String? currentVendorId;
  CartType? currentCartType;
  Restaurant? selectedRestaurant;

  List<String> cartType = ['المطاعم', 'المتاجر', 'الماركت'];
  RxString selectedCartType = 'المطاعم'.obs;

  void onAddressTypeChanged(String value) {
    selectedCartType.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  Future<void> loadCart() async {
    final items = await CartDb.instance.getAllItems();
    cartItems.assignAll(items);
    if (items.isNotEmpty) {
      currentVendorId = items.first.vendorId;
      currentCartType = items.first.cartType;
    }

    selectedRestaurant = await CartDb.instance.getRestaurant();
  }

  Future<void> addToCart(CartItem newItem, {Restaurant? restaurant}) async {
    if (currentCartType != null && currentCartType != newItem.cartType) {
      Get.snackbar('تنبيه', 'لا يمكنك خلط أنواع سلة مختلفة');
      return;
    }

    if (currentVendorId != null && currentVendorId != newItem.vendorId) {
      Get.snackbar('تنبيه', 'لا يمكنك إضافة منتجات من مورد مختلف');
      return;
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

    // حفظ المطعم إذا لم يكن محفوظ مسبقاً
    if (selectedRestaurant == null && restaurant != null) {
      await CartDb.instance.saveRestaurant(restaurant);
      selectedRestaurant = restaurant;
    }
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
      selectedRestaurant = null;
      await CartDb.instance.clearRestaurant();
    }
  }

  Future<void> clearCart() async {
    await CartDb.instance.clearCart();
    await CartDb.instance.clearRestaurant();
    cartItems.clear();
    currentVendorId = null;
    currentCartType = null;
    selectedRestaurant = null;
  }

  double get total =>
      cartItems.fold(0.0, (sum, item) => sum + item.price1 * item.quantity);
}
