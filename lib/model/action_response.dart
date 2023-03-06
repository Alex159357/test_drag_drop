


import 'package:test_drag_drop/model/responce_value.dart';

class ActionResponse {
  String status;
  ResponseValue value;

  ActionResponse({required this.status, required this.value});


  factory ActionResponse.fromMap(Map<String, dynamic> map) =>  ActionResponse(status: map["status"], value: ResponseValue.fromMap(map["value"]));

}