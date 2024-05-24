import 'package:dio/dio.dart';

import 'package:egytraveler/shared/components/constants.dart';
import 'package:egytraveler/core/resources/string_manager.dart';

class DioHelper {
  static late Dio dio;

  static late Dio dioRe;

  static inti() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppStrings.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );

    dioRe = Dio(
      BaseOptions(
        baseUrl: 'https://recomend.codepeak.live/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getDate(
      {required String url,
      Map<String, dynamic>? query,
      dynamic data,
      String tokenVerify = ''}) async {
    dio.options.headers = {
      'Authorization': 'Bearer ${tokenVerify.isEmpty ? token : tokenVerify}',
    };
    return await dio.get(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      required dynamic data,
      String tokenVerify = ''}) async {
    dio.options.headers = {
      'Authorization': 'Bearer ${tokenVerify.isEmpty ? token : tokenVerify}',
    };
    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    dynamic data,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return dio.delete(
      url,
      data: data,
    );
  }

  static Future<Response> getDateRe(
      {required String url,
      Map<String, dynamic>? query,
      dynamic data,
      String tokenVerify = ''}) async {
    dioRe.options.headers = {
      'Authorization': 'Bearer ${tokenVerify.isEmpty ? token : tokenVerify}',
    };
    return await dioRe.get(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
