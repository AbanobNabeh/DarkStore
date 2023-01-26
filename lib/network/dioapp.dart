import 'package:darkstore/components/linkapi.dart';
import 'package:dio/dio.dart';

class DioApp {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: API,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
  }) async {
    return await dio.get(
      url,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
