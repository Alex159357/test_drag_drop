import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_drag_drop/model/widget_model.dart';

import '../helpers/main_mapper.dart';
import '../helpers/states/widget_types.dart';
import '../home_screen.dart';
import '../model/action_response.dart';
import '../model/switch_model.dart';


class RequestInterceptor<T, E> extends Interceptor with MainMapper<T, E> {

  String specialKey = "";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //do not remove as Map<String, dynamic>
    (options.data as Map<String, dynamic>).addAll({"token": token} as Map<String, dynamic>);
    if (kDebugMode) {
      print("real_resquest -> ${options.data}");
    }
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
    if (kDebugMode) {
      print("real_response -> ${response.data}");
    }
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
    Fluttertoast.showToast(msg: err.message!, backgroundColor: Colors.redAccent, textColor: Colors.white);
    super.onError(err, handler);
  }


}