import 'package:flutter/material.dart';
import 'package:test_drag_drop/helpers/states/widget_types.dart';
import 'package:test_drag_drop/model/widget_model.dart';
import 'package:collection/collection.dart';

class SwitchModel implements WidgetModel {
  @override
  int? id;

  @override
  String? moduleId;

  @override
  String? moduleName;

  @override
  String? name;

  @override
  String? time;

  @override
  double? dx;

  @override
  double? dy;


  SwitchModel(
      {this.id,
      this.moduleId,
      this.moduleName,
      this.name,
      this.time,
      this.dx,
      this.dy});

  SwitchModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    moduleId = json['module_id'].toString();
    name = json['name'].toString();
    dx = double.tryParse(json['x']);
    dy = double.tryParse(json['y']);
    moduleName = json['module_name'];
    time = json['time'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['module_id'] = moduleId;
    data['name'] = name;
    data['x'] = dx.toString();
    data['y'] = dy.toString();
    data['module_name'] = moduleName;
    data['time'] = time;
    return data;
  }

  @override
  void changeCoordinates({required double dx, required double dy}) {
    this.dx = dx;
    this.dy = dy;
  }

  @override
  String? moduleHubId;

}
