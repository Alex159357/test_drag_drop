import 'package:flutter/material.dart';
import 'package:test_drag_drop/helpers/states/widget_types.dart';
import 'package:test_drag_drop/model/widget_model.dart';
import 'package:collection/collection.dart';

class SwitchModel implements WidgetModel {
  @override
  int id;

  @override
  String name;

  @override
  double dx;

  @override
  double dy;

  @override
  WidgetTypes type;

  @override
  String tag;

  bool state;

  @override
  String? hubId;

  @override
  int? rssi;

  @override
  bool? status;

  @override
  String? swver;

  @override
  double? vPower;

  @override
  String? objectName;

  SwitchModel({
    required this.id,
    required this.name,
    required this.dx,
    required this.dy,
    required this.type,
    required this.state,
    required this.tag,
    required this.objectName,
    required this.vPower,
    required this.swver,
    required this.status,
    required this.rssi,
    required this.hubId,
  });

  @override
  void changeCoordinates({required double dx, required double dy}) {
    this.dx = dx;
    this.dy = dy;
  }

  // "id": "1",
  // "object_name": "Advisor Demo",
  // "hub_id": "1020210708130621",
  // "name": "null",
  // "status": "true",
  // "rssi": "null",
  // "vpower": "null",
  // "swver": "null"

  factory SwitchModel.fromMap(Map<String, dynamic> map) => SwitchModel(
        id:  int.parse(map["id"].toString()),
        name: map["name"],
        dx: 0,
        dy:  0,
        type: WidgetTypes.SWITCH,
        state: false,
        tag:  "",
        objectName: map["object_name"],
        vPower: double.tryParse(map["vpower"]),
        swver: map["swver"],
        status: false,
        rssi: int.tryParse(map["rssi"]),
        hubId: map["rssi"].toString(),
      );

  @override
  WidgetModel? fromMap(Map<String, dynamic> json)=> SwitchModel.fromMap(json);
}
