

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_drag_drop/helpers/states/widget_types.dart';

import '../../../../bloc/drag/drag_bloc.dart';
import '../../../../bloc/drag/drag_event.dart';
import '../../../../bloc/drag/drag_state.dart';
import '../../../../model/climate_control_model.dart';
import '../../../../model/module_id.dart';
import '../../../../model/widget_model.dart';
import 'expanded_widget.dart';

class ClimateControlPaneWidget extends StatelessWidget {
  final ClimateControlModel wm;
  late DragBloc bloc;
  final double widgetSize = 70;

  ClimateControlPaneWidget({Key? key, required this.wm}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    bloc = context.read<DragBloc>();
    return _getDraggable;
  }

  Widget get _getDraggable => BlocBuilder<DragBloc, DragState>(
    builder: (BuildContext context, state) {
      ModuleModel curModel = state.modelList.firstWhere((element) => element.id == wm.moduleId);
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
              duration: Duration(milliseconds: 500),
              opacity: state.didItemOverRemoveTarget ? 0.4 : 1,
              child: state.expandedId == wm.id
                  ? ExpandedWidget(widgetModel: wm, bloc: bloc,)
                  : SizedBox(
                width: widgetSize,
                height: widgetSize,
                child: const Material(
                  color: Colors.transparent,
                ),
              ),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: state.expandedId == wm.id
                  ? Column(
                children: [
                  ExpandedWidget(widgetModel: wm, bloc: bloc,),
                ],
              )
                  : MouseRegion(
                onHover: (b) {
                  // if(!state.holdState) {
                  //   bloc.add(OnHoverWidget(switchModel.id));
                  // }
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
                          color: const Color(0xFF8287ff)
                              .withOpacity(.8)),
                      child: InkWell(
                        onTap: () => bloc.add(
                            OnWidgetClickedDragEvent(
                                clickedId: wm.id!)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              wm.name!,
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    state.hoverId == wm.id
                        ? Container(
                      padding: EdgeInsets.symmetric(
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
            ),
          );
        },
      );
    },
  );
}
