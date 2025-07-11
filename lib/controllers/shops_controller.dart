import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/data/models/product_model.dart';

import '../data/models/cart_item.dart';
import '../data/models/restaurant.dart';
import '../data/models/category.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/values_constant.dart';
import 'cart_item_controller.dart';

class ShopsController extends GetxController {
  CartItemController cartItemController = Get.find<CartItemController>();
  // Select Restaurant
  Rx<Restaurant?> restaurantSelect = Rx(null);
  void selectRestorent(Restaurant restaurant) {
    restaurantSelect(restaurant);
    // Get.toNamed(AppRoutes.shopShopsScreen);
  }

  RxInt countView() =>
      (Values.width ~/ 500 == 0 ? 1 : (Values.width / 500).round()).obs;

  void addToCart(
    Product product,
    String note,
    int quantity, {
    bool isBack = true,
  }) {
    cartItemController.addToCart(
      CartItem(
        vendorName: restaurantSelect.value!.name,
        productId: product.id.toString(),
        name: product.name,
        image: product.image,
        note: note,
        price2: product.price2,
        price1: product.price1,
        quantity: quantity,
        vendorId: restaurantSelect.value!.id.toString(),
        cartType: CartType.shop,
      ),
      restaurant: restaurantSelect.value!,

      isBack: isBack,
    );
  }
  //Filter

  static List<FilterOption> filterOptions = [
    FilterOption(label: 'الكل'),
    FilterOption(label: 'توصيل مجاني'),
    // FilterOption(label: 'خصم'),
    FilterOption(label: 'مفتوح'),
  ];
  Rx<FilterOption> selectFilterOption = Rx(filterOptions[0]);
  void selectFilter(FilterOption filter) async {
    for (var element in filterOptions) {
      element.isSelect = false;
    }
    filter.isSelect = true;
    selectFilterOption(filter);
    if (selectCategories.value == null) {
      await fetchRestaurant();
    } else {
      await fetchRestaurant(categoryId: selectCategories.value!.id);
    }
  }

  RxBool isLoading = false.obs;
  RxBool isLoadingStart = true.obs;
  RxBool isLoadingRestaurant = true.obs;
  RxBool isLoadingSliderImageModel = true.obs;
  ScrollController scrollController = ScrollController();

  RxList<Category> restaurantCategories = RxList([]);
  Rx<Category?> selectCategories = Rx(null);

  void selectCategory(Category category) {
    selectCategories(category);
    fetchRestaurant(categoryId: category.id);
  }

  RxList<Restaurant> restaurants = RxList([]);
  var isAppBarVisible = true.obs;
  double previousOffset = 0.0;
  DateTime? lastTime;

  @override
  void onInit() {
    super.onInit();
    fetchCategores();
    fetchRestaurant();

    //MessageSnak.message("تم جلب البيانات ", color: ColorApp.greenColor);
    // scrollController.addListener(_scrollListener);

    // scrollController.addListener(() {
    //   if (scrollController.position.pixels >=
    //       scrollController.position.maxScrollExtent - 100) {
    //     // fetchVideos();
    //   }
    // });
  }

  Future<void> fetchCategores() async {
    isLoading.value = true;

    try {
      final StateReturnData response = await ApiService.getData(
        ApiConstants.shopMainCategories,
      );

      if (response.isStateSucess < 3) {
        List<dynamic> newVideosJson = response.data;

        List<Category> newRestaurantCategory = Category.fromJsonList(
          newVideosJson,
        );
        restaurantCategories.clear();
        restaurantCategories.add(
          Category(
            image: 'https://iili.io/3hzRl7s.png',
            id: 0,
            name: "الكل",
            type: '',
          ),
        );
        restaurantCategories.addAll(newRestaurantCategory);
        selectCategories(restaurantCategories[0]);
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    }
    isLoadingStart(false);
    isLoading.value = false;
  }

  int pageRestaurant = 1;
  Future<void> fetchRestaurant({int categoryId = 0}) async {
    isLoadingRestaurant.value = true;

    try {
      final StateReturnData response = await ApiService.postData(
        ApiConstants.resturensOrShop(
          pageRestaurant,
          freeDelevry: filterOptions[1].isSelect,
          categoryId: 0,
          type: 'shop',
        ),
        {},
      );
      if (response.isStateSucess < 3) {
        List<dynamic> newVideosJson = response.data['data'];

        List<Restaurant> newRestaurantCategory = Restaurant.fromJsonList(
          newVideosJson,
        );
        restaurants([]);
        restaurants.addAll(newRestaurantCategory);
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    } finally {
      isLoadingRestaurant(false);
    }
  }
}

class FilterOption {
  final String label;
  bool isSelect;
  FilterOption({required this.label, this.isSelect = false});
}
