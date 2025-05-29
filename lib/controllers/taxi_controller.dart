import 'package:get/get.dart';

class TaxiController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<Taxi?> selectedTaxi = Rx<Taxi?>(null);
  Rx<String?> selectedTaxiAddress = Rx<String?>(null);
  List<String> addressType = ['عناويني', 'المدخلات الأخيرة'];
  RxString selectedAddressType = 'عناويني'.obs;

  void onAddressTypeChanged(String value) {
    selectedAddressType.value = value;
  }

  void selectLocation(Taxi location, String address) {
    selectTaxi(location);
    selectTaxiAddress(address);
    print('Selected Location: ${location.name}, Address: $address');
    print('Selected Location: ${selectedTaxi.value!.name} ');
    print('Selected Location: ${selectedTaxiAddress.value} ');
  }

  void selectTaxi(taxi) {
    selectedTaxi.value = taxi;
    selectedTaxiAddress.value = null;
  }

  void selectTaxiAddress(taxi) {
    selectedTaxiAddress.value = taxi;
  }

  // -----
  List<Taxi> taxiAddresses = [
    Taxi(
      name: 'داخل بسماية',
      addresses: ['البناية 1', 'البناية 2', 'البناية 3'],
    ),
    Taxi(
      name: 'خارج بسماية',
      addresses: ['شارع بغداد', 'شارع فلسطين', 'شارع اليرموك'],
    ),
    Taxi(
      name: 'المنطقة الخضراء',
      addresses: ['شارع الرشيد', 'شارع الجمهورية', 'شارع السعدون'],
    ),
    Taxi(
      name: 'المنطقة الدولية',
      addresses: ['شارع المطار', 'شارع القادسية', 'شارع النصر'],
    ),
    Taxi(
      name: 'المنطقة الصناعية',
      addresses: ['شارع الصناعة', 'شارع الميكانيك', 'شارع الكهرباء'],
    ),
    Taxi(
      name: 'المنطقة التجارية',
      addresses: ['شارع التجارة', 'شارع السوق', 'شارع البنوك'],
    ),
    Taxi(
      name: 'المنطقة السكنية',
      addresses: ['شارع السكن', 'شارع الأحياء', 'شارع الحدائق'],
    ),
  ];
}

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
  String toString() {
    return name;
  }
}
