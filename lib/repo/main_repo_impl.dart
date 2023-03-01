
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_drag_drop/helpers/main_mapper.dart';
import 'package:test_drag_drop/helpers/states/api_values.dart';
import 'package:test_drag_drop/repo/client_impl.dart';

import '../helpers/constaints.dart' as lnk;
import '../helpers/constaints.dart';
import '../model/switch_model.dart';
import '../model/widget_model.dart';
import 'client.dart';
import 'main_repo.dart';

class MainRepoImpl implements MainRepo{


  @override
  Future<List<WidgetModel>?> getDeviceList(Map<String, dynamic> req) async {
    Client client = ClientImpl<WidgetModel, List>("result");
    return await client.callPost(data: {
      "object_id": "1",
      "token": "99d10fe4-1b2e-4a75-87a3-aa6c2c2d08dd"
    }, apiValues: ApiValues.DEVICE_LIST);
  }

}