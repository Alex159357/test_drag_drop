import 'package:flutter/material.dart';

import '../helpers/states/widget_types.dart';

class WidgetModel {
  int? id;
  String? moduleId;
  String? name;
  double? dx;
  double? dy;
  String? moduleHubId;
  String? moduleName;
  String? time;

  WidgetModel(
      {this.id,
        this.moduleId,
        this.name,
        this.dx,
        this.dy,
        this.moduleName,
        this.moduleHubId,
        this.time});

  WidgetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleId = json['module_id'];
    name = json['name'];
    dx = json['x'];
    dy = json['y'];
    moduleName = json['module_name'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['module_id'] = moduleId;
    data['name'] = name;
    data['x'] = dx.toString();
    data['y'] = dy.toString();
    data['module_name'] = moduleName;
    data['time'] = time;
    data["hubid"] = moduleHubId;
    return data;
  }

  void changeCoordinates({required double dx, required double dy}) {
    this.dx = dx;
    this.dy = dy;
  }
}
