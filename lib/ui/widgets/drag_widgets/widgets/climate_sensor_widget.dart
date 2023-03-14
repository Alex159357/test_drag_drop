import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_drag_drop/bloc/drag/drag_bloc.dart';
import 'package:test_drag_drop/helpers/states/widget_types.dart';
import 'package:test_drag_drop/model/widget_model.dart';

import '../../../../bloc/drag/drag_event.dart';
import '../../../../bloc/drag/drag_state.dart';
import '../../../../drag_view.dart';
import '../../../../model/climate_sensor_model.dart';
import '../../../../model/module_id.dart';
import 'package:collection/collection.dart';

class ClimateSensor extends StatelessWidget {
  final ClimateSensorModel wm;
  late DragBloc bloc;
  final double widgetSize = 70;

  ClimateSensor({Key? key, required this.wm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc = context.read<DragBloc>();
    return _getDraggable;
  }

  Widget get _getDraggable => BlocBuilder<DragBloc, DragState>(
    builder: (BuildContext context, state) {
      ModuleModel? curModel = state.modelList.firstWhereOrNull((element) => element.id == wm.moduleId);
      return Draggable<int>(
        onDragEnd: (d) {
          bloc.add(OnWidgetMoved(id: wm.id!.toString(), dx: d.offset.dx, dy: d.offset.dy));
          bloc.add(OnWidgetPositionChanged(
              dx: d.offset.dx,
              dy: d.offset.dy,
              id: wm.id!));
        },
        onDragStarted: () {
          bloc.add(OnHoldStateChanged(true));
        },
        onDragCompleted: () {},
        onDraggableCanceled: (d, v) {
          bloc.add(OnHoldStateChanged(false));
        },
        data: wm.id,
        feedback: _getContent(curModel),
        child: InkWell(
            onTap: () => bloc.add(OnWidgetClickedDragEvent(clickedId: wm.id!)),
            child: _getContent(curModel))
      );
    },
  );

  Widget _getContent(ModuleModel? curModel) => Container(
    width: widgetSize,
    height: widgetSize,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: Colors.white, width: 2),
        color: const Color(0xFFff98ff)
            .withOpacity(.8)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          wm.name!,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    ),
  );

}
