import 'package:test_drag_drop/helpers/states/widget_types.dart';
import 'package:test_drag_drop/model/widget_model.dart';

class CounterModel implements WidgetModel {
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

  String value;


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

  CounterModel(
      {required this.dx,
      required this.dy,
      required this.id,
      required this.name,
      required this.tag,
      required this.type,
      required this.value,
        required this.vPower,
        required this.swver,
        required this.status,
        required this.rssi,
        required this.hubId,
        required this.objectName,
      });

  @override
  void changeCoordinates({required double dx, required double dy}) {
    this.dx = dx;
    this.dy = dy;
  }

}
