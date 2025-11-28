import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/routes/app_routes.dart';

import '../data/models/user_model.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/color_app.dart';
import '../views/widgets/message_snak.dart';
import 'storage_controller.dart';

class TaxiController extends GetxController {
  TextEditingController startingPointController = TextEditingController();
  TextEditingController endPointController = TextEditingController();
  RxString startingPointText = ''.obs;
  RxString endPointText = ''.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();

    startingPointController.addListener(() {
      startingPointText.value = startingPointController.value.text;
    });

    endPointController.addListener(() {
      endPointText.value = endPointController.value.text;
    });
  }

  // يتحكم في عرض واجهة الانطلاق أو الوصول
  RxBool isCompleteStartingPoint = false.obs;

  List<TaxiViewName> textTitles = [
    TaxiViewName(
      title: 'حدد نقطة الانطلاق',
      subtitle: 'يرجى تحديد نقطة الانطلاق التي سيتوجه السائق إليها ليقلك منها.',
    ),
    TaxiViewName(
      title: 'حدد نقطة الوصول',
      subtitle: 'يرجى تحديد نقطة الوصول التي ترغب ان يقلك السائق إليها.',
    ),
  ];

  Rx<TaxiViewName> textTitle =
      TaxiViewName(
        title: 'حدد نقطة الانطلاق',
        subtitle:
            'يرجى تحديد نقطة الانطلاق التي سيتوجه السائق إليها ليقلك منها.',
      ).obs;
  void selectLocation(Taxi location, String address) {
    selectTaxi(location);
    selectTaxiAddress(address);
    setCompleteStartingPoint(true);
  }

  String get startingPointFullText =>
      startingPointController.text.isNotEmpty
          ? startingPointController.text
          : 'بناية ${selectedTaxi.value} , بلوك ${selectedTaxiAddress.value}';

  String get endPointFullText =>
      endPointController.text.isNotEmpty
          ? endPointController.text
          : 'بناية ${selectedTaxi2.value} , بلوك ${selectedTaxiAddress2.value}';

  void setCompleteStartingPoint(bool value) {
    isCompleteStartingPoint.value = value;
    textTitle.value = value ? textTitles[1] : textTitles[0];
  }

  void setCompleteEndPoint(bool value) {
    Get.toNamed(AppRoutes.checkTripInformaition);
    // isCompleteStartingPoint.value = value;
    // textTitle.value = value ? textTitles[1] : textTitles[0];
  }

  RxBool isLoadingTaxiCreate = false.obs;
  void submetOrderTaxi() async {
    //    {
    //   "from": "${addressModel!.buildingNo}|${addressModel!.blockNo}",
    //   "to":"",//text
    //   "status": "new",
    //   "fromLat": "",//
    //   "toLat": "",
    //   "fromLong": "",
    //   "toLong": "",
    //   "userId":"",
    //   "userPhone":"",
    //   "userNote": "string",
    //   "driverNote": "string",
    //   "publicNote": "string",
    //   "type": "taxi"
    // }

    try {
      isLoadingTaxiCreate(true);
      UserModel userModel = UserModel.fromJson(StorageController.getAllData());

      final StateReturnData response = await ApiService.postData(
        ApiConstants.creatTaxiOrders,
        {
          "from": startingPointFullText,
          "to": endPointFullText,
          "status": "new",
          "fromLat": "0.0", // يجب استبداله بالإحداثيات الفعلية
          "toLat": "0.0", // يجب استبداله بالإحداثيات الفعلية
          "fromLong": "0.0", // يجب استبداله بالإحداثيات الفعلية
          "toLong": "0.0", // يجب استبداله بالإحداثيات الفعلية
          "userId": userModel.id, // يجب استبداله بمعرف المستخدم الفعلي
          "userPhone": userModel.phone, // يجب استبداله برقم الهاتف الفعلي
          "userNote": "",
          "driverNote": "",
          "publicNote": "",
          "type": "taxi",
        },
      );
      // logger.e('Taxi Order response Data: ${response.data}');
      if (response.isStateSucess < 3) {
        Get.offAllNamed(AppRoutes.home);
        MessageSnak.message(
          'تم إرسال طلب التاكسي بنجاح',
          color: ColorApp.greenColor,
        );
      } else {
        MessageSnak.message('فشل إرسال طلب التاكسي');
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    } finally {
      isLoadingTaxiCreate(false);
    }
    // isCompleteStartingPoint.value = value;
    // textTitle.value = value ? textTitles[1] : textTitles[0];
  }

  // بيانات العنوان الأول (الانطلاق)
  Rx<Taxi?> selectedTaxi = Rx<Taxi?>(null);
  Rx<String?> selectedTaxiAddress = Rx<String?>(null);

  void selectTaxi(Taxi taxi) {
    selectedTaxiAddress.value = null;
    selectedTaxi.value = taxi;
  }

  void selectTaxiAddress(String address) {
    selectedTaxiAddress.value = address;
    startingPointController.text = '';
  }

  // بيانات العنوان الثاني (الوصول)
  Rx<Taxi?> selectedTaxi2 = Rx<Taxi?>(null);
  Rx<String?> selectedTaxiAddress2 = Rx<String?>(null);

  void selectTaxi2(Taxi taxi) {
    selectedTaxiAddress2.value = null;
    selectedTaxi2.value = taxi;
  }

  void selectTaxiAddress2(String address) {
    selectedTaxiAddress2.value = address;
    endPointController.text = '';
  }

  // أنواع العناوين (للتبديل بين قائمة العناوين والاخيرة)
  List<String> addressType = ['عناويني', 'المدخلات الأخيرة'];
  RxString selectedAddressType = 'عناويني'.obs;

  void onAddressTypeChanged(String value) {
    selectedAddressType.value = value;
  }

  // عناوين افتراضية
}

List<Taxi> taxiAddresses = [
  Taxi(name: 'A1', addresses: List.generate(12, (index) => '${index + 1}')),
  Taxi(name: 'A2', addresses: List.generate(14, (index) => '${index + 1}')),
  Taxi(name: 'A3', addresses: List.generate(14, (index) => '${index + 1}')),
  Taxi(name: 'A4', addresses: List.generate(12, (index) => '${index + 1}')),
  Taxi(name: 'A5', addresses: List.generate(12, (index) => '${index + 1}')),
  Taxi(name: 'A6', addresses: List.generate(12, (index) => '${index + 1}')),
  Taxi(name: 'A7', addresses: List.generate(13, (index) => '${index + 1}')),
  Taxi(name: 'A8', addresses: List.generate(15, (index) => '${index + 1}')),
  Taxi(name: 'A9', addresses: List.generate(15, (index) => '${index + 1}')),
  Taxi(name: 'B1', addresses: List.generate(12, (index) => '${index + 1}')),
  Taxi(name: 'B2', addresses: List.generate(18, (index) => '${index + 1}')),
  Taxi(name: 'B3', addresses: List.generate(18, (index) => '${index + 1}')),
  Taxi(name: 'B8', addresses: List.generate(12, (index) => '${index + 1}')),
];

// الموديل المستخدم للعناوين
class Taxi {
  String name;
  List<String> addresses;

  Taxi({required this.name, required this.addresses});

  factory Taxi.fromJson(Map<String, dynamic> json) {
    return Taxi(
      name: json['name'] as String,
      addresses: List<String>.from(json['addresses'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'addresses': addresses};
  }

  @override
  String toString() => name;
}

// بيانات العنوان (العنوان + وصف)
class TaxiViewName {
  String title;
  String subtitle;

  TaxiViewName({required this.title, required this.subtitle});
}




// Restaurant and shops

// get Categories
// https://rayhan.shop/api/ShopMainCategories - this use only on restaurant page to get main categories

// Search about product
// If u want restaurant product send restaurant else send shop
// https://rayhan.shop/api/Shop/Filter?type=name&value=${searchTextEditController.text}&hisType=restaurant


// Restaurant banners
// https://rayhan.shop/api/ShopShow


// Get restaurant as filter
// 'https://rayhan.shop/api/Shop/ForUser?pageSize=$pageSize&page=$page&categoryId=$category&sort=${restController.sort.value}&grantThan4Star=${restController.grantThe4Star.value}&freeDelivery=${restController.freeDelivery.value}&type=$type'

// Page and pageSize for pagination
// Category is category id if not found send 0 
// Sort send “Ascending” or “Descending” 
// grantThan4Star send true or false 
// freeDelivery send true or false
// Type send restaurant or shop 

// Get products as category id
// https://rayhan.shop/api/ShopProduct/ForUser?page=$page&pageSize=$pageSize&categoryId=$category
 

// Get category for restaurant or shop 
// https://rayhan.shop/api/ShopCategory/ShopCategoriesFilter?shopId=$id