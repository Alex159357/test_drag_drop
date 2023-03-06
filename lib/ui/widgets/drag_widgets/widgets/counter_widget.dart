import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_drag_drop/helpers/states/widget_types.dart';
import 'package:test_drag_drop/ui/widgets/drag_widgets/widgets/expanded_widget.dart';

import '../../../../bloc/drag/drag_bloc.dart';
import '../../../../bloc/drag/drag_event.dart';
import '../../../../bloc/drag/drag_state.dart';
import '../../../../model/counter_model.dart';
import '../../../../model/widget_model.dart';

class CounterWidget extends StatelessWidget {
  final CounterModel wm;
  late DragBloc bloc;
  final double widgetSize = 100;

  CounterWidget({Key? key, required this.wm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc = context.read<DragBloc>();
    return _getDraggable;
  }

  Widget get _getDraggable => BlocBuilder<DragBloc, DragState>(
        builder: (BuildContext context, state) {
          return BlocBuilder<DragBloc, DragState>(
            builder: (BuildContext context, state) {
              return Draggable<int>(
                onDragEnd: (d) {
                  // bloc.add(OnWidgetPositionChanged(
                  //     dx: d.offset.dx, dy: d.offset.dy, id: switchModel.id));
                },
                onDragUpdate: (d) {
                  bloc.add(OnWidgetPositionChanged(
                      dx: d.localPosition.dx,
                      dy: d.localPosition.dy -
                          MediaQuery.of(context).viewPadding.top,
                      id: wm.id));
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
                  child:
                  // state.expandedId == wm.id
                  //     ? ExpandedWidget(widgetModel: wm, bloc: bloc,)
                  //     :
                  SizedBox(
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
                            // ExpandedWidget(widgetModel: wm, bloc: bloc,),
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
                                    color: const Color(0xFFa8ff97)
                                        .withOpacity(.8)),
                                child: InkWell(
                                  onTap: () => bloc.add(
                                      OnWidgetClickedDragEvent(
                                          clickedId: wm.id)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        wm.value,
                                        style: TextStyle(color: Colors.white),
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
                                          Text(wm.name),
                                          Text(wm.tag),
                                          Text(wm.type.getTitle),
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
