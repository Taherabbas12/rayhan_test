import 'package:get/get.dart';

import '../data/models/cart_item.dart';
import '../data/models/product_model.dart';
import '../data/models/shop_category.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/values_constant.dart';
import 'cart_item_controller.dart';
import 'market_controller.dart';

class MarketProductController extends GetxController {
  MarketController marketController = Get.find<MarketController>();
  RxBool isLoading = false.obs;
  RxBool isLoadingProduct = false.obs;
  RxBool isLoadingStart = true.obs;
  RxList<Product> productsMarket = RxList([]);
  RxList<ShopCategory> marketSubCategories = RxList([]);
  Rx<ShopCategory?> selectSubCategories = Rx(null);

  @override
  void onInit() {
    super.onInit();

    fetchSubCategores(marketController.selectCategories.value!.id);
  }

  RxInt countView() =>
      (Values.width ~/ 250 == 0 ? 1 : (Values.width / 250).round()).obs;

  void selectCategory(ShopCategory category) {
    selectSubCategories.value = category;
    fetchMarketProducts(
      idCategores: marketController.selectCategories.value!.id,
      subCategorie: category.id,
    );
  }

  CartItemController cartItemController = Get.find<CartItemController>();

  void addToCart(
    Product product,
    String note,
    int quantity, {
    bool isBack = true,
  }) {
    cartItemController.addToCart(
      CartItem(
        vendorName: '',
        productId: product.id.toString(),
        name: product.name,
        image: product.image,
        note: note,
        price2: product.price2,
        price1: product.price1,
        quantity: quantity,
        vendorId: '',
        cartType: CartType.mart,
      ),

      isBack: isBack,
    );
  }

  Future<void> fetchSubCategores(int id) async {
    isLoading.value = true;

    try {
      final StateReturnData response = await ApiService.postData(
        ApiConstants.marketSubCatagorys(id),
        {},
      );
      print('_______222A');

      print(response.data);
      logger.e("response  $id: ${response.data.toString()}");

      if (response.isStateSucess < 3) {
        List<dynamic> newVideosJson = response.data;

        List<ShopCategory> newRestaurantCategory = ShopCategory.fromJsonList(
          newVideosJson,
        );
        marketSubCategories.clear();
        marketSubCategories.add(ShopCategory(id: 0, name: "الكل"));
        marketSubCategories.addAll(newRestaurantCategory);
        selectSubCategories(marketSubCategories[0]);

        fetchMarketProducts(
          idCategores: marketController.selectCategories.value!.id,
          subCategorie: marketSubCategories[0].id,
        );
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    }
    isLoadingStart(false);
    isLoading.value = false;
  }

  Future<void> fetchMarketProducts({
    required int idCategores,
    int subCategorie = 0,
  }) async {
    isLoadingProduct.value = true;

    try {
      final StateReturnData response = await ApiService.getData(
        ApiConstants.marketProduct(idCategores, subCategory: subCategorie),
      );
      print(idCategores);
      print(subCategorie);

      logger.e("response $idCategores : ${response.data}");
      if (response.isStateSucess < 3) {
        List<dynamic> newJson = response.data['products'];

        List<Product> newProductMarket = Product.fromJsonList(newJson);
        productsMarket.clear();

        productsMarket.addAll(newProductMarket);
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    }

    isLoadingProduct.value = false;
  }
}
