import 'package:dio/dio.dart';

import '../controllers/storage_controller.dart';
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
        if (StorageController.checkLoginStatus())
          'Authorization': 'Bearer ${StorageController.getToken()}',
        if (!StorageController.checkLoginStatus())
          'Authorization':
              'Bearer 249|bzKWe3XnKsg0UbJKjgVAQ0nFd5SosPbRzqoSLLUMbd52abba',
        // 'Authorization':
        //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJZb3VyU3ViamVjdCIsImp0aSI6Ijc2Y2YxNWVlLWMyOWItNDg2MC1hODhkLTBiMDU4YjY3NWYyYyIsImlhdCI6IjcvMTMvMjAyNSA1OjM0OjEwIFBNIiwiZXhwIjoyNTM0MDIzMDA4MDAsImlzcyI6IllvdXJJc3N1ZXIiLCJhdWQiOiJZb3VyQXVkaWVuY2UifQ._6fGCfpFIPWBCaEbGRbX4LBmxu-sB7j-ZmtgSm3rMno',
        // 'Content-Type': 'multipart/form-data',
        'Content-Type': 'application/json',
      },
    ),
  );

  static void updateToken() {
    _dio.options.headers['Authorization'] =
        'Bearer ${StorageController.getToken()}';
  }

  static void updateTokenLogin() {
    _dio.options.headers['Authorization'] =
        'Bearer 249|bzKWe3XnKsg0UbJKjgVAQ0nFd5SosPbRzqoSLLUMbd52abba';
  }

  static void updateTokenString(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // دالة GET لجلب البيانات وإرجاعها على شكل Map
  static Future<StateReturnData> getData(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
       if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        return StateReturnData(1, response.data);
      }
      return StateReturnData(2, response.data);
    } catch (e) {
      logger.i('Error in Post request: $e');
      return StateReturnData(3, {});
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
