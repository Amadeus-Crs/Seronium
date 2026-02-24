import 'package:dio/dio.dart';
import 'package:seronium_flutter/constants/index.dart';

class Apiservice {
  static final Dio _dio = Dio();
  Apiservice(){
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..sendTimeout=Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
  }
}