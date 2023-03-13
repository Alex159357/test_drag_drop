import 'dart:convert';

import 'package:test_drag_drop/helpers/states/widget_types.dart';
import 'package:test_drag_drop/model/climate_control_model.dart';
import 'package:test_drag_drop/model/climate_sensor_model.dart';
import 'package:test_drag_drop/model/counter_model.dart';
import 'package:test_drag_drop/model/module_id.dart';
import 'package:test_drag_drop/model/widget_model.dart';

import '../model/action_response.dart';
import '../model/hub_id_model.dart';
import '../model/switch_model.dart';

class MainMapper<T, E> {

  dynamic mapData({required dynamic data, String specialKey = ""}){
    if (specialKey.isNotEmpty) {
      var map = json.decode(data.toString())[specialKey];
      if (map is List) {
        List<T> convertedList = [];
        for (var e in map) {
          if(T == WidgetModel) {
            T? res = _mapToList(e);
            convertedList.add(res as T);
          }else{
            var mapped = _mapDataModels(e);
            if(mapped != null) {
              convertedList.add(mapped);
            }
          }
        }
        data = convertedList;
      }
    } else {
      if (data != null) {
        return _mapToModel(json.decode(data.toString()));
      }
    }
    return data;
  }

  T? _mapToModel(Map<String, dynamic> map) {
    if (T == ActionResponse) {
      return ActionResponse.fromMap(map) as T;
    }
    return null;
  }

  T? _mapToList(Map<String, dynamic> map) {
    final widgetType =  _getWidgetTypeById(map["module_id"]);
    if (widgetType != null) {
      switch (widgetType) {
        case WidgetTypes.SWITCH:
          return SwitchModel.fromJson(map) as T;
        case WidgetTypes.COUNTER:
          return CounterModel.fromJson(map) as T;
        case WidgetTypes.CLIMATE_SENSOR:
          return ClimateSensorModel.fromJson(map) as T;
        case WidgetTypes.CLIMATE_CONTROL_PANEL:
          return ClimateControlModel.fromJson(map) as T;
        case WidgetTypes.UNDEFINED:
          return SwitchModel.fromJson(map) as T;
      }
    }
    return null;
  }


  WidgetTypes? _getWidgetTypeById(String id) {
    if(id.length >4) {
      if (id.substring(0, 4) == "2040") {
        return WidgetTypes.CLIMATE_SENSOR;
      } else if (id.substring(0, 4) == "2041") {
        return WidgetTypes.CLIMATE_SENSOR;
      } else if (id.substring(0, 4) == "2042") {
        return WidgetTypes.CLIMATE_SENSOR;
      } else if (id.substring(0, 4) == "2043") {
        return WidgetTypes.COUNTER;
      } else if (id.substring(0, 4) == "2044" ||
          id.substring(0, 4) == "2045" ||
          id.substring(0, 4) == "2046" ||
          id.substring(0, 4) == "2047" ||
          id.substring(0, 4) == "2048" ||
          id.substring(0, 4) == "2044") {
        return WidgetTypes.CLIMATE_SENSOR;
      } else if (id.substring(0, 4) == "2070") {
        return WidgetTypes.SWITCH;
      }
    }else {
      return null;
    }
    return null;
  }

  T? _mapDataModels(Map<String, dynamic> map){
    switch(T){
      case HubIdModel: return HubIdModel.fromMap(map) as T?;
      case ModuleModel: return ModuleModel.fromMap(map) as T?;
    }
    return null;

  }

}
