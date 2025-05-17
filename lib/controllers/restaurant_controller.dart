import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/routes/app_routes.dart';

import '../data/models/restaurant.dart';
import '../data/models/category.dart';
import '../data/models/slider_image_model.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/values_constant.dart';

class RestaurantController extends GetxController {
  // Select Restaurant
  Rx<Restaurant?> restaurantSelect = Rx(null);
  void selectRestorent(Restaurant restaurant) {
    restaurantSelect(restaurant);
    Get.toNamed(AppRoutes.shopScreen);
  }

  RxInt countView() =>
      (Values.width ~/ 500 == 0 ? 1 : (Values.width / 500).round()).obs;

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

  RxList<SliderImageModel> sliderImageModel = RxList([]);
  RxList<Restaurant> restaurants = RxList([]);
  var isAppBarVisible = true.obs;
  double previousOffset = 0.0;
  DateTime? lastTime;

  void _scrollListener() {
    double offset = scrollController.position.pixels;
    double threshold = 20.0; // الحد الأدنى للحركة لتغيير الحالة

    // إذا عدت إلى البداية، قم بتعيين isAppBarVisible إلى true
    if (offset == 0.0) {
      isAppBarVisible.value = true;
    }

    DateTime now = DateTime.now();
    double velocity = 0.0;

    if (lastTime != null) {
      double timeDiff =
          now.difference(lastTime!).inMilliseconds / 1000.0; // الزمن بالثواني
      velocity =
          ((offset - previousOffset).abs()) /
          timeDiff; // سرعة التمرير (بكسل/ثانية)
    }

    double velocityThreshold = 500.0; // الحد الأدنى لسرعة السحب السريع

    if ((offset - previousOffset).abs() > threshold &&
        velocity > velocityThreshold) {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        isAppBarVisible.value =
            false; // إخفاء الـ AppBar عند السحب للأسفل بسرعة
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        isAppBarVisible.value = true; // إظهار الـ AppBar عند السحب للأعلى بسرعة
      }
    }

    previousOffset = offset;
    lastTime = now; // تحديث الوقت السابق

    // تحميل المزيد عند الاقتراب من نهاية القائمة
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      // fetchVideos();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCategores();
    fetchRestaurant();
    fetchSliderImage();
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
        ApiConstants.resturens(
          pageRestaurant,
          freeDelevry: filterOptions[1].isSelect,
          categoryId: categoryId,
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

  Future<void> fetchSliderImage() async {
    isLoadingSliderImageModel.value = true;

    try {
      final StateReturnData response = await ApiService.getData(
        ApiConstants.shopShowBanners,
      );
      if (response.isStateSucess < 3) {
        List<dynamic> newVideosJson = response.data;

        List<SliderImageModel> newRestaurantCategory =
            SliderImageModel.fromJsonList(newVideosJson);
        sliderImageModel([]);
        sliderImageModel.addAll(newRestaurantCategory);
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    } finally {
      isLoadingSliderImageModel(false);
    }
  }
}

class FilterOption {
  final String label;
  bool isSelect;
  FilterOption({required this.label, this.isSelect = false});
}
