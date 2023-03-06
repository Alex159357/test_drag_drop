
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_drag_drop/helpers/main_mapper.dart';
import 'package:test_drag_drop/helpers/states/api_values.dart';
import 'package:test_drag_drop/repo/client_impl.dart';

import '../helpers/constaints.dart' as lnk;
import '../helpers/constaints.dart';
import '../model/action_response.dart';
import '../model/switch_model.dart';
import '../model/widget_model.dart';
import 'client.dart';
import 'main_repo.dart';

class MainRepoImpl implements MainRepo{


  @override
  Future<List<WidgetModel>?> getDeviceList(Map<String, dynamic> req) async {
    Client client = ClientImpl<WidgetModel, List<WidgetModel>>("result");

    var res = await client.callPost(data: {
      "object_id": "1",
      "token": "99d10fe4-1b2e-4a75-87a3-aa6c2c2d08dd"
    }, apiValues: ApiValues.DEVICE_LIST);


    return res;

  }

  @override
  Future<bool> passAction({required String hubid, required int id, required bool state}) async{
    final outState = state? 1 : 0;
    var req = {
      "hubid":"$hubid",
      "token": "99d10fe4-1b2e-4a75-87a3-aa6c2c2d08dd",
      "value":"{\"action\":\"setManual\",\"data\":{\"idOut\":\"$id\",\"paramOut\":\"DO3\",\"setValue\":\"$outState\"}}"
    };
    Client client = ClientImpl<ActionResponse, void>("");
    ActionResponse actionResponse = await client.callPost(data: req, apiValues: ApiValues.DEVICE_ACTION);
    if (kDebugMode) {
      print("ActionResult -> ${actionResponse.status}");
    }
    return false;
  }

}