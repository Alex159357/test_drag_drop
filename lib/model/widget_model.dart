import 'package:flutter/material.dart';

import '../helpers/states/widget_types.dart';

abstract class WidgetModel {
  late int id;
  late WidgetTypes type;
  late double dx;
  late double dy;
  late String name;
  late String tag;
  late String? objectName;
  late String? hubId;
  late bool? status;
  late int? rssi;
  late double? vPower;
  late String? swver;


  void changeCoordinates({required double dx, required double dy}) {
    this.dx = dx;
    this.dy = dy;
  }


}
