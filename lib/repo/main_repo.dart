

import 'package:test_drag_drop/model/module_id.dart';
import 'package:test_drag_drop/model/widget_model.dart';

import '../model/hub_id_model.dart';

abstract class MainRepo {


  Future<List<WidgetModel>?> fetchWidgets();

  Future<bool> passAction({required String hubid, required String id, required bool state});

  Future<List<HubIdModel>?> fetchHubs();

  Future<List<WidgetModel>?> addDevice(Map<String, dynamic> req);

  Future<List<ModuleModel>?> fetchModuleList(int objectId);

  Future<void> widgetMoved(WidgetModel widgetModel);

  Future<List<WidgetModel>?> deleteWidget(int id);

}