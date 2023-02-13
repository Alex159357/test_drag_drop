import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_drag_drop/bloc/drag/drag_bloc.dart';
import 'package:test_drag_drop/model/widget_model.dart';

import '../../../../bloc/drag/drag_event.dart';
import '../../../../bloc/drag/drag_state.dart';

class WidgetType1 extends StatelessWidget {
  final WidgetModel wm;
  late DragBloc bloc;

  WidgetType1({Key? key, required this.wm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc = context.read<DragBloc>();
    return Stack(
      children: [
        _getDraggable,
        // _getExpandedWidget,
      ],
    );
  }

  Widget get _getDraggable => BlocBuilder<DragBloc, DragState>(
        builder: (BuildContext context, state) {
          return Draggable<int>(
            onDragEnd: (d) {
              bloc.add(OnWidgetPositionChanged(
                  dx: d.offset.dx, dy: d.offset.dy, id: wm.id));
            },
            onDragUpdate: (d) {
              bloc.add(OnHoldStateChanged(true));
            },
            onDragCompleted: () {},
            onDraggableCanceled: (d, v) {
              bloc.add(OnHoldStateChanged(false));
            },
            data: wm.id,
            feedback: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: state.didItemOverRemoveTarget ? 0.4 : 1,
              child:state.expandedId == wm.id?
                  Container(
                    child: Container(
                      color: Colors.grey.withOpacity(.5),
                      width: 300,
                      height: 400,
                      child: Column(
                        children: [
                          Container(
                            height: 54,
                            width: double.infinity,
                            color: Colors.grey.withOpacity(.8),
                          ),
                        ],
                      ),
                    ),
                  )
                  : ClipOval(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                  child: Icon(
                    Icons.touch_app,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ),
            ),
            child: AnimatedPhysicalModel(
              duration: const Duration(milliseconds: 700),
              color: state.expandedId == wm.id ? Colors.white : Colors.blue.withOpacity(0.7),
              elevation: state.expandedId == wm.id ? 9 : 3,
              shape: BoxShape.rectangle,
              shadowColor: Colors.black,
              borderRadius: state.expandedId == wm.id
                  ? const BorderRadius.all(Radius.circular(8))
                  : const BorderRadius.all(Radius.circular(999)),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: state.expandedId == wm.id? 300 :  100,
                  height: state.expandedId == wm.id? 400 :  100,
                  color: Colors.transparent,
                  child: state.expandedId == wm.id
                      ?
                  Column(
                    children: [
                      AppBar(
                        actions: <Widget>[
                          Container(
                            color: Colors.red,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6),
                            child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                onPressed: () => bloc
                                    .add(OnWidgetClickedDragEvent(-1))),
                          )
                        ],
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0; i < 5; i++)
                              ListTile(
                                title: Text("Title $i"),
                                subtitle: Text("Subtitle $i"),
                              )
                          ],
                        ),
                      ),
                    ],
                  )
                  :Positioned(
                    child: Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () =>
                            bloc.add(OnWidgetClickedDragEvent(wm.id)),
                        child: Material(
                          color: Colors.transparent,
                          child: Center(child: Icon(Icons.camera, size: 50, color: Colors.white.withOpacity(.7),),)
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );

  Widget get _getExpandedWidget => BlocBuilder<DragBloc, DragState>(
        builder: (BuildContext context, state) {
          BorderRadius start;
          BorderRadius end;

          return Positioned(
            child: AnimatedSize(
              duration: Duration(milliseconds: 500),
              child: AnimatedPhysicalModel(
                duration: Duration(seconds: 1),
                color: state.expandedId == wm.id ? Colors.red : Colors.blue,
                elevation: state.expandedId == wm.id ? 9 : 3,
                shape: BoxShape.rectangle,
                shadowColor: Colors.deepOrangeAccent,
                borderRadius: state.expandedId == wm.id
                    ? const BorderRadius.all(Radius.circular(0))
                    : const BorderRadius.all(Radius.circular(24)),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(9999)),
                  width: state.expandedId == wm.id ? null : 0.0,
                  height: state.expandedId == wm.id ? null : 0.0,
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.amber,
                          width: 300,
                          height: 400,
                          child: Column(
                            children: [
                              AppBar(
                                actions: <Widget>[
                                  Container(
                                    color: Colors.red,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: IconButton(
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                        onPressed: () => bloc
                                            .add(OnWidgetClickedDragEvent(-1))),
                                  )
                                ],
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    for (int i = 0; i < 5; i++)
                                      ListTile(
                                        title: Text("Title $i"),
                                        subtitle: Text("Subtitle $i"),
                                      )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
}
