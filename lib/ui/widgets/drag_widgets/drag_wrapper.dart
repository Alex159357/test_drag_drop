import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_drag_drop/model/climate_control_model.dart';
import 'package:test_drag_drop/model/climate_sensor_model.dart';
import 'package:test_drag_drop/model/switch_model.dart';
import 'package:test_drag_drop/model/widget_model.dart';
import 'package:test_drag_drop/ui/widgets/drag_widgets/widgets/counter_widget.dart';
import 'package:test_drag_drop/ui/widgets/drag_widgets/widgets/switch_widget.dart';
import 'package:test_drag_drop/ui/widgets/drag_widgets/widgets/climate_sensor_widget.dart';
import 'package:test_drag_drop/ui/widgets/drag_widgets/widgets/climate_controlPabel_widget.dart';

import '../../../drag_view.dart';
import '../../../helpers/states/widget_types.dart';
import '../../../model/counter_model.dart';

class DragWrapper extends StatelessWidget {
  WidgetModel widgetModel;

  DragWrapper({Key? key, required this.widgetModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RenderBox renderBox = dragKey.currentContext!.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);
    return AnimatedPositioned(
        curve: Curves.easeInToLinear,
        duration: const Duration(milliseconds: 300),
        left: widgetModel.dx,
        top: widgetModel.dy! > position.dy? widgetModel.dy! - position.dy : widgetModel.dy!,
        child: Container(
            // width: 70,
            // height: 70,
            child:
                _getChild(WidgetType.fromId(int.parse(widgetModel.moduleId!)), widgetModel.dx!, widgetModel.dy!)));
  }

  Widget _getChild(WidgetTypes type, double dx, double dy) {
    switch (type) {
      case WidgetTypes.SWITCH:
        return SwitchWidget(wm: widgetModel as SwitchModel);
      case WidgetTypes.CLIMATE_CONTROL_PANEL:
        return ClimateControlPaneWidget(
          wm: widgetModel as ClimateControlModel,
        );
      case WidgetTypes.CLIMATE_SENSOR:
        return ClimateSensor(
          wm: widgetModel as ClimateSensorModel,
        );
      case WidgetTypes.COUNTER:
        return CounterWidget(
          wm: widgetModel as CounterModel,
        );
      default:
        return Container();
    }
  }
}
