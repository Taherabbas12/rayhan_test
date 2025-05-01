import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../data/models/restaurant_category.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';

class ServicesController extends GetxController {
  //
  RxBool isLoading = false.obs;
  RxBool isLoadingStart = true.obs;
  ScrollController scrollController = ScrollController();

  RxList<Category> servicesCategories = RxList([]);
  Rx<Category?> servicesCategorie = Rx(null);
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
    //MessageSnak.message("تم جلب البيانات ", color: ColorApp.greenColor);
    // scrollController.addListener(_scrollListener);

    // scrollController.addListener(() {
    //   if (scrollController.position.pixels >=
    //       scrollController.position.maxScrollExtent - 100) {
    //     // fetchVideos();
    //   }
    // });
  }

  void selectSection(Category category) {
    servicesCategorie.value = category;
  }

  Future<void> fetchCategores({bool isNotNext = true}) async {
    isLoading.value = true;

    try {
      final StateReturnData response = await ApiService.getData(
        ApiConstants.serviceMainCategory,
      );
      logger.e(response.data);
      if (response.isStateSucess < 3) {
        List<dynamic> newVideosJson = response.data;

        List<Category> newRestaurantCategory = Category.fromJsonList(
          newVideosJson,
        );

        servicesCategories.addAll(newRestaurantCategory);
        if (servicesCategories.isNotEmpty) {
          servicesCategorie.value = servicesCategories[0];
        }
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    }
    isLoadingStart(false);
    isLoading.value = false;
  }
}
