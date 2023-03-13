import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_drag_drop/bloc/drag/drag_bloc.dart';
import 'package:test_drag_drop/helpers/states/widget_types.dart';
import 'package:test_drag_drop/model/widget_model.dart';

import '../../../../bloc/drag/drag_event.dart';
import '../../../../bloc/drag/drag_state.dart';
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
      return BlocBuilder<DragBloc, DragState>(
        builder: (BuildContext context, state) {
          return Draggable<int>(
            onDragEnd: (d) {
              bloc.add(OnWidgetMoved(id: wm.id!.toString(), dx: d.offset.dx, dy: d.offset.dy));
            },
            onDragUpdate: (d) {
              bloc.add(OnWidgetPositionChanged(
                  dx: d.localPosition.dx,
                  dy: d.localPosition.dy -
                      MediaQuery.of(context).viewPadding.top,
                  id: wm.id!));
              bloc.add(OnHoldStateChanged(true));
            },
            onDragStarted: () {},
            onDragCompleted: () {},
            onDraggableCanceled: (d, v) {
              bloc.add(OnHoldStateChanged(false));
            },
            data: wm.id,
            feedback: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: state.didItemOverRemoveTarget ? 0.4 : 1,
              // child: state.expandedId == wm.id
              //     ? ExpandedWidget(widgetModel: wm, bloc: bloc,)
              //     : SizedBox(
              //   width: widgetSize,
              //   height: widgetSize,
              //   child: const Material(
              //     color: Colors.transparent,
              //   ),
              // ),
            ),
            child: state.expandedId == wm.id
                ? Column(
              children: [
                // ExpandedWidget(widgetModel: wm, bloc: bloc,),
              ],
            )
                : MouseRegion(
              onHover: (b) {
                if(!state.holdState) {
                  // bloc.add(OnHoverWidget(wm.id));
                }
              },
              child: Column(
                children: [
                  Container(
                    width: widgetSize,
                    height: widgetSize,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white, width: 2),
                        color: const Color(0xFFff98ff)
                            .withOpacity(.8)),
                    child: InkWell(
                      onTap: () => bloc.add(OnWidgetClickedDragEvent(clickedId: wm.id!)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            wm.name!,
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  state.hoverId == wm.id
                      ? Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16),
                    color: Colors.black12,
                    child: Column(
                      children: [
                        Text(wm.name!),
                        Text(wm.moduleName!),
                        Text(WidgetType.fromId(wm.id!).getTitle),
                      ],
                    ),
                  )
                      : Container()
                ],
              ),
            ),
          );
        },
      );
    },
  );
  // AnimatedPhysicalModel(
  // duration: const Duration(milliseconds: 700),
  // color: state.expandedId == wm.id ? Colors.white : Colors.blue.withOpacity(0.7),
  // elevation: state.expandedId == wm.id ? 9 : 3,
  // shape: BoxShape.rectangle,
  // shadowColor: Colors.black,
  // borderRadius: state.expandedId == wm.id
  // ? const BorderRadius.all(Radius.circular(8))
  //     : const BorderRadius.all(Radius.circular(999)),
  // child: AnimatedSize(
  // duration: const Duration(milliseconds: 300),
  // child: Container(
  // width: state.expandedId == wm.id? 300 :  100,
  // height: state.expandedId == wm.id? 400 :  100,
  // color: Colors.transparent,
  // child: state.expandedId == wm.id
  // ?
  // Column(
  // children: [
  // AppBar(
  // actions: <Widget>[
  // Container(
  // color: Colors.red,
  // padding: const EdgeInsets.symmetric(
  // horizontal: 6),
  // child: IconButton(
  // icon: const Icon(
  // Icons.close,
  // color: Colors.white,
  // ),
  // onPressed: () => bloc
  //     .add(OnWidgetClickedDragEvent(-1))),
  // )
  // ],
  // ),
  // SingleChildScrollView(
  // child: Column(
  // children: [
  // for (int i = 0; i < 5; i++)
  // ListTile(
  // title: Text("Title $i"),
  // subtitle: Text("Subtitle $i"),
  // )
  // ],
  // ),
  // ),
  // ],
  // )
  //     :Positioned(
  // child: Align(
  // alignment: Alignment.center,
  // child: InkWell(
  // onTap: () =>
  // bloc.add(OnWidgetClickedDragEvent(wm.id)),
  // child: Material(
  // color: Colors.transparent,
  // child: Center(child: Icon(Icons.camera, size: 50, color: Colors.white.withOpacity(.7),),)
  // ),
  // ),
  // ),
  // ),
  // ),
  // ),
  // )

}
