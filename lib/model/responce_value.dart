
import 'action_response_value_data.dart';

class ResponseValue{
  String action;
  ActionResponseValueData data;

  ResponseValue({required this.action, required this.data});

  factory ResponseValue.fromMap(Map<String, dynamic> map) => ResponseValue(action: map["action"], data: ActionResponseValueData.fromMap(map["data"]));

}