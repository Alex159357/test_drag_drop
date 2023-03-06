import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:test_drag_drop/model/widget_model.dart';

import '../helpers/main_mapper.dart';
import '../helpers/states/widget_types.dart';
import '../model/action_response.dart';
import '../model/switch_model.dart';


class RequestInterceptor<T, E> extends Interceptor with MainMapper<T, E> {

  String specialKey = "";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.connectTimeout = const Duration(minutes: 5);
    options.receiveTimeout = const Duration(minutes: 5);
    options.baseUrl = "http://95.67.62.214:8777/api/";
    options.headers['content-Type'] = 'application/json';
    options.headers['accept'] = 'application/json';
    options.headers['access-control-allow-origin'] = '*';
    super.onRequest(options, handler);
  }


  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try{
      response.data = mapData(data: response.data, specialKey: specialKey);
    }catch(e){
      if (kDebugMode) {
        print("MapperError -> $e");
      }
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }


}