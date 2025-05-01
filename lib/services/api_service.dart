import 'package:dio/dio.dart';

import '../utils/constants/api_constants.dart';
import 'error_message.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      validateStatus: (status) {
        return status! < 500; // Adjust based on your needs
      },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
        // if (StorageController.checkLoginStatus())
        //   'Authorization': 'Bearer ${StorageController.getToken()}',
        // 'Authorization':
        //     'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL21lZGlhcmVnaXN0cmF0aW9uLmFsa2FmZWVsLm5ldC9hcGkvYXV0aC9sb2dpbiIsImlhdCI6MTczOTkwMTc5NSwiZXhwIjozNjMyMDYxNzk1LCJuYmYiOjE3Mzk5MDE3OTUsImp0aSI6IlRQbEdjd3ZJaWxvR2pwa1MiLCJzdWIiOiI3NTMiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.hDp7JOpFbp02whySb2uOdn1pFbM5MooP9pxHYIELwz8',
        // 'Content-Type': 'multipart/form-data',
        'Content-Type': 'application/json',
      },
    ),
  );

  // static void updateToken() {
  //   _dio.options.headers['Authorization'] =
  //       'Bearer ${StorageController.getToken()}';
  // }

  // دالة GET لجلب البيانات وإرجاعها على شكل Map
  static Future<StateReturnData> getData(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);

      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        return StateReturnData(1, response.data); // إرجاع البيانات كـ Map
      }
      return StateReturnData(2, response.data);
    } catch (e) {
      logger.i('Error in Post request: $e');
      return StateReturnData(3, {}); // إرجاع خريطة فارغة في حال الخطأ
    }
  }

  // دالة POST لإرسال البيانات وإرجاع النتيجة كـ Map
  static Future<StateReturnData> postData(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      // logger.i(response.data);
      // logger.i('State Code : ${response.statusCode}');

      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        return StateReturnData(1, response.data);
      }
      return StateReturnData(3, response.data);
    } catch (e) {
      if (e is DioException) {
        logger.i('DioError: ${e.response?.data}');
        logger.i('DioError status: ${e.response?.statusCode}');
      } else {
        logger.i('Error: $e');
        return StateReturnData(3, {});
      }
      // showLongMessageDialog('Error: $e');
      logger.i('Error in Post request: $e');

      return StateReturnData(3, {});
    }
  }

  static Future<StateReturnData> putData(String endpoint, dynamic data) async {
    try {
      final response = await _dio.put(endpoint, data: data);

      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        return StateReturnData(1, response.data); // إرجاع البيانات كـ Map
      }
      return StateReturnData(2, response.data);
    } catch (e) {
      logger.i('Error in Update request: $e');
      return StateReturnData(3, {}); // إرجاع خريطة فارغة في حال الخطأ
    }
  }

  static Future<StateReturnData> deleteData(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);

      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        return StateReturnData(1, response.data); // إرجاع البيانات كـ Map
      }
      return StateReturnData(2, response.data);
    } catch (e) {
      logger.i('Error in DELETE request: $e');
      return StateReturnData(3, {}); // إرجاع خريطة فارغة في حال الخطأ
    }
  }
}

class StateReturnData {
  int isStateSucess;
  dynamic data;
  StateReturnData(this.isStateSucess, this.data);
}
