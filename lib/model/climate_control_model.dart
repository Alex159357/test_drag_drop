import 'package:test_drag_drop/helpers/states/widget_types.dart';
import 'package:test_drag_drop/model/widget_model.dart';

class ClimateControlModel implements WidgetModel {
  @override
  double dx;

  @override
  double dy;

  @override
  int id;

  @override
  String name;

  @override
  String tag;

  @override
  WidgetTypes type;

  @override
  String? hubId;

  @override
  String? objectName;

  @override
  int? rssi;

  @override
  bool? status;

  @override
  String? swver;

  @override
  double? vPower;

  ClimateControlModel(
      {required this.dx,
      required this.dy,
      required this.id,
      required this.name,
      required this.tag,
      required this.type,
      required this.objectName,
      required this.hubId,
      required this.rssi,
      required this.status,
      required this.swver,
      required this.vPower});

  @override
  void changeCoordinates({required double dx, required double dy}) {
    this.dx = dx;
    this.dy = dy;
  }
}
