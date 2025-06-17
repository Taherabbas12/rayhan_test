import 'package:get/get.dart';
import '../data/database/cart_db.dart';
import '../data/models/cart_item.dart';
import '../data/models/restaurant.dart';
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

    selectedRestaurant.value = await CartDb.instance.getRestaurant();
  }

  Future<void> addToCart(
    CartItem newItem, {
    Restaurant? restaurant,
    bool isBack = true,
  }) async {
    if (currentCartType != null && currentCartType != newItem.cartType) {
      MessageSnak.message('لا يمكنك خلط أنواع سلة مختلفة');
      return;
    }

    if (currentVendorId != null && currentVendorId != newItem.vendorId) {
      MessageSnak.message('لا يمكنك إضافة منتجات من مورد مختلف');

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
}
