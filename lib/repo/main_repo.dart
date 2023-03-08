

import 'package:test_drag_drop/model/widget_model.dart';

import '../model/hub_id_model.dart';

abstract class MainRepo {


  Future<List<WidgetModel>?> getDeviceList(Map<String, dynamic> req);

  Future<bool> passAction({required String hubid, required int id, required bool state});

  Future<List<HubIdModel>?> loadHubs();

}