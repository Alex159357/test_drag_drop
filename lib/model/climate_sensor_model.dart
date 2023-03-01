import 'package:test_drag_drop/helpers/states/widget_types.dart';
import 'package:test_drag_drop/model/widget_model.dart';

class ClimateSensorModel implements WidgetModel {
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

  String temperature;

  String humidity;

  String cO2;

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

  ClimateSensorModel(
      {required this.dx,
      required this.dy,
      required this.id,
      required this.name,
      required this.tag,
      required this.type,
      required this.temperature,
      required this.humidity,
      required this.cO2,
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
