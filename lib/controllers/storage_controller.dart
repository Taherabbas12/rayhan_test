import 'package:get_secure_storage/get_secure_storage.dart';
import '../utils/constants/values_constant.dart';

class StorageController {
  static GetSecureStorage getSecureStorage = GetSecureStorage(
    container: Values.pathContiner,
    password: Values.passwordStorage,
  );
  static bool checkLoginStatus() {
    return GetSecureStorage(
          container: Values.pathContiner,
        ).read(Values.keyStorage) !=
        null;
  }

  static String getToken() {
    var data = getSecureStorage.read(Values.keyStorage);
    //  .i(data['token'] ?? '');
    //  .i('--------- $data  -aa-------------');

    try {
      return data['token'] ?? '';
    } catch (e) {
      return '';
    }
  }

  static bool isAuthorized(String id) {
    var data = getSecureStorage.read(Values.keyStorage);

    try {
      return data['data']['id'] == id;
    } catch (e) {
      return false;
    }
  }

  static Map<String, dynamic> getAllData() {
    var data = getSecureStorage.read(Values.keyStorage);
    //  .i('--------- $data  --------------');

    return data ?? {};
  }

  static Future<void> storeData(Map data) async {
    await getSecureStorage.write(Values.keyStorage, data);
  }

  static Future<void> storeDataTheme(bool isDark) async {
    await getSecureStorage.write(Values.keyStorageTheme, isDark);
  }

  static bool getDataTheme() {
    bool isDark = getSecureStorage.read(Values.keyStorageTheme) ?? true;
    return isDark;
  }

  static bool getDataThemeisNull() {
    return getSecureStorage.read(Values.keyStorageTheme) == null;
  }

  static Future<void> updateData(Map data) async {
    //  .i(data);
    var data2 = await getSecureStorage.read(Values.keyStorage);
    data2['data'] = data['data'];
    await getSecureStorage.write(Values.keyStorage, data2);
  }

  static Future<void> removeData() async {
    await getSecureStorage.remove(Values.keyStorage);
  }
  // static Future<void> checkLogin() async {
  //   // customer

  //   StateReturnData data = await ApiService.getData(ApiConstants.customer);

  //   if (data.isStateSucess == 1) {
  //     if (data.data['data'] != null) {}
  //   } else if (data.data['message'] == "Unauthenticated.") {
  //     await GetSecureStorage(container: Values.pathContiner)
  //         .remove(Values.keyStorage);
  //   }
  // }
}
