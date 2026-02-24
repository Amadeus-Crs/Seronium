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
      _addInterceptors();
  }
  Future<dynamic> get(String url , Map<String,dynamic>? params){
    return _handleResponse(_dio.get(url,queryParameters: params));
  }
  Future<dynamic> post(String url , Map<String,dynamic>? data){
    return _handleResponse(_dio.post(url,data: data));
  }
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task)async{
    try{
      Response res = await task;
      final data = res.data;
      if(data['code']==GlobalConstants.SUCCESS_CODE){
      return data['data'];
    }else{
      throw DioException(requestOptions: res.requestOptions,message: data['msg']??'加载数据失败');
    }}catch(e){
      rethrow;
    }
  }
  void _addInterceptors(){
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request,handler){
        handler.next(request); 
      },
      onResponse: (response,handler){
        if(response.statusCode! >=200 && response.statusCode! <300){
          handler.next(response);
          return;
        }
        handler.reject(DioException(requestOptions: response.requestOptions));
      },
      onError: (error,handler){
        handler.reject(DioException(requestOptions: error.requestOptions,message: error.response?.data['msg']??''));
      }
    ),);
  }
}

final apiService = Apiservice();