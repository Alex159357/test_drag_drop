import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/drag/drag_bloc.dart';
import '../../../../bloc/drag/drag_event.dart';
import '../../../../bloc/drag/drag_state.dart';
import '../../../../drag_view.dart';
import '../../../../model/module_id.dart';
import '../../../../model/switch_model.dart';
import '../../../state/base_state_less.dart';
import 'package:collection/collection.dart';

class SwitchWidget extends BaseStateLess {
  final SwitchModel wm;
  late DragBloc bloc;
  final double widgetSize = 70;
  final gKey = UniqueKey();
  final double expandedWidgetWidth = 300;
  final double expandedWidgetHeight = 400;


  SwitchWidget({Key? key, required this.wm});

  @override
  Widget build(BuildContext context) {

    bloc = context.read<DragBloc>();
    return Material(
        borderOnForeground: false,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        color: Colors.transparent,
        elevation: 0,
        child: _getDraggable);
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
            onDragUpdate: (d) {
              // RenderBox renderBox = context.findRenderObject() as RenderBox;
              // print("Move ${renderBox}");

              // bloc.add(OnWidgetPositionChanged(
              //     dx: d.globalPosition.dx,
              //     dy: d.globalPosition.dy -
              //         MediaQuery.of(context).viewPadding.top,
              //     id: wm.id!));
              // bloc.add(OnHoldStateChanged(true));
            },
            onDragStarted: () {
              bloc.add(OnHoldStateChanged(true));
            },
            onDragCompleted: () {},
            onDraggableCanceled: (d, v) {
              bloc.add(OnHoldStateChanged(false));
            },
            data: wm.id,
            feedback: _getContent(curModel) ,
            child: MouseRegion(
                    onHover: (b) {
                      // if(!state.holdState) {
                      //   bloc.add(OnHoverWidget(switchModel.id));
                      // }
                    },
                    child: InkWell(
                        onTap: () {
                          bloc.add(OnWidgetClickedDragEvent(clickedId: wm.id!));
                        },
                        child: _getContent(curModel))
                    // Column(
                    //   children: [
                    //     Container(
                    //       width: widgetSize,
                    //       height: widgetSize,
                    //       decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           border:
                    //               Border.all(color: Colors.white, width: 2),
                    //           color: Colors.brown.withOpacity(.5)),
                    //       child:
                    //       InkWell(
                    //         onTap: () {
                    //          bloc.add(OnWidgetClickedDragEvent(clickedId: wm.id!));
                    //         },
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(18.0),
                    //           child: CupertinoSwitch(
                    //             trackColor: Colors.black12,
                    //             value: curModel?.status == "true",
                    //             onChanged: (bool value) {
                    //               bloc.add(OnSwitchStateChanged(id: wm.id!, state: value));
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
          );
        },
      );

  Widget _getContent(ModuleModel? curModel) => Container(
    width: widgetSize,
    height: widgetSize,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        border:
        Border.all(color: Colors.white, width: 2),
        color: Colors.brown.withOpacity(.5)),
    child:
    Padding(
      padding: const EdgeInsets.all(18.0),
      child: CupertinoSwitch(
        trackColor: Colors.black12,
        value: curModel?.status == "true",
        onChanged: (bool value) {
          bloc.add(OnSwitchStateChanged(id: wm.id!, state: value));
        },
      ),
    ),
  );

}
