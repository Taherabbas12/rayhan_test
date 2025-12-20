import 'package:get/get.dart';
import 'package:rayhan_test/data/models/address_model.dart';
import '../data/models/home_response.dart';
import '../data/models/restaurant.dart';
import '../data/models/slider_image_model.dart';
import '../data/models/user_model.dart';
import '../services/api_service.dart';
import '../utils/constants/api_constants.dart';
import '../services/error_message.dart';
import 'storage_controller.dart';

class HomeGetAllController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt minmumOrder = RxInt(0);
  RxInt deleveryId = RxInt(0);
  RxInt deleveryPrice = RxInt(0);
  // الأقسام
  HomeResponseModel allData = HomeResponseModel(
    forNow: <Restaurant>[].obs,
    shows: <ShowsItemModel>[].obs,
    sliderImageModel: <SliderImageModel>[].obs,
    freeDeliveryCount: 0,
    freeDelivery: <Restaurant>[].obs,
  );
  // RxList<ShowsItemModel> shows = RxList([]);
  // RxList<SliderImageModel> sliderImageModel = RxList([]);
  // RxInt freeDeliveryCount = 0.obs;
  Rx<AddressModel?> adddress = Rx(null);

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
    getMinmumOrder();
  }

  Future<void> fetchHomeData() async {
    isLoading.value = true;

    try {
      final response = await ApiService.postData(
        ApiConstants.getAllDataHome,
        {},
      );
      // logger.w(response.data);
      if (response.isStateSucess < 3) {
        final HomeResponseModel allDataTemp = HomeResponseModel.fromJson(
          response.data,
        );

        allData.forNow.assignAll(allDataTemp.forNow);
        allData.freeDelivery.assignAll(allDataTemp.freeDelivery);
        allData.shows.assignAll(allDataTemp.shows);
        allData.sliderImageModel.assignAll(allDataTemp.sliderImageModel);
        allData.freeDeliveryCount = allDataTemp.freeDeliveryCount;

        // تحديث الـ RxList
        // allData.assignAll(data);
        // shows.assignAll(data.shows);
        // logger.e(forNowShop.first.toJson());
        // sliderImageModel.assignAll(data.sliderImageModel);
        // freeDeliveryCount.value = data.freeDeliveryCount;
        // ___________________
        getAddress();
        // ___________________
      } else {
        logger.i("❌ فشل في جلب بيانات الهوم");
      }
    } catch (e) {
      logger.i("❌ خطأ في تحميل البيانات: $e");
    }

    isLoading.value = false;
  }

  Future<void> getAddress() async {
    UserModel userModel = UserModel.fromJson(StorageController.getAllData());

    final response2 = await ApiService.getData(
      ApiConstants.tbAddressesById(userModel.addressid),
    );

    // logger.w('_______ Address ${userModel.addressid} ________');
    // logger.w(response2.data);
    if (response2.isStateSucess < 3) {
      adddress.value = null;
      adddress.value = AddressModel.fromJson(response2.data);

      //
    }
  }

  Future<void> getMinmumOrder() async {
    final response2 = await ApiService.getData(ApiConstants.tbOptions);

    if (response2.isStateSucess < 3) {
      List data = response2.data;
      Map<dynamic, dynamic> value = data.firstWhere(
        (e) => e['name'] == 'minmumOrder',
      );
      minmumOrder(int.tryParse(value['value2']) ?? 0);
      Map<dynamic, dynamic> value2 = data.firstWhere(
        (e) => e['value1'] == 'delevery',
      );
      deleveryId(int.tryParse(value2['value2']) ?? 0);

      getDeleveryPrice();
    }
  }

  void getDeleveryPrice() async {
    final response2 = await ApiService.getData(
      ApiConstants.deleveryPrice(deleveryId.value),
    );
    logger.w(response2.data);

    if (response2.isStateSucess < 3) {
      deleveryPrice(int.tryParse(response2.data['price'] ?? 0) ?? 0);
      // shippingprices/3
      logger.w(deleveryPrice.value);
    }
  }
}
