import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_drag_drop/bloc/drag/drag_state.dart';
import 'package:test_drag_drop/ui/state/base_state_less.dart';
import 'package:test_drag_drop/ui/view/add_widget_view.dart';
import 'package:test_drag_drop/ui/widgets/drag_widgets/drag_wrapper.dart';
import 'package:test_drag_drop/ui/widgets/drag_widgets/widgets/expanded_widget.dart';
import 'package:test_drag_drop/ui/widgets/drag_widgets/widgets/widget_size_render_object.dart';
import 'bloc/drag/drag_bloc.dart';
import 'bloc/drag/drag_event.dart';
import 'helpers/constaints.dart';
import 'model/widget_model.dart';


GlobalKey dragKey = GlobalKey();

class DragViewWidget extends BaseStateLess with AddWidgetDialog {
  late DragBloc bloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TransformationController controller = TransformationController();

  DragViewWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<DragBloc>(context);
    return BlocListener<DragBloc, DragState>(
        listener: (BuildContext context, state) {
          if (state.expandedId >= 0) {
            // _scaffoldKey.currentState!.openDrawer();
          }else{
            // _scaffoldKey.currentState!.closeDrawer();
          }
          if (state.didUpdateScene) {
            controller.value = Matrix4(
              state.zoom,
              0,
              0,
              0,
              0,
              state.zoom,
              0,
              0,
              0,
              0,
              1,
              0,
              0,
              0,
              0,
              1,
            );
          }
        },
        child: _getBody);
  }

  Widget get _getBody => BlocBuilder<DragBloc, DragState>(
        builder: (BuildContext context, state) {
          return Scaffold(
            key: _scaffoldKey,
            drawer: Container(
              height: double.infinity,
              color: Colors.white,
              child: state.expandedId >=0? ExpandedWidget(
                widgetModel: state.widgetList
                    .firstWhere((element) => element.id == state.expandedId),
                bloc: bloc,
              ) : Container(),
            ),
            body: Stack(
              children: [
                MouseRegion(
                  cursor: state.holdState
                      ? SystemMouseCursors.none
                      : SystemMouseCursors.basic,
                  child: Stack(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width,
                            maxWidth: MediaQuery.of(context).size.width,
                            maxHeight: MediaQuery.of(context).size.height,
                            minHeight: MediaQuery.of(context).size.height),
                        child: Container(
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  ElevatedButton(
                                    child: const Icon(Icons.zoom_in),
                                    onPressed: () => bloc.add(OnZoomIn()),
                                  ),
                                  ElevatedButton(
                                    child: const Icon(Icons.zoom_out),
                                    onPressed: () => bloc.add(OnZoomOut()),
                                  ),
                                ],
                              ),
                              Container(
                                key: dragKey,
                                child: Stack(
                                  children: [
                                    WidgetSizeOffsetWrapper(
                                        onSizeChange: (Size size) {
                                          bloc.add(InitSize(
                                              width: size.width,
                                              height: size.height));
                                        },
                                        child: Container(
                                            child: Image.asset(
                                                "assets/plan_1.png"))),
                                    _getDragTarget,

                                    for (WidgetModel wm in state.widgetList)
                                      state.widgetList.isNotEmpty?
                                      DragWrapper(
                                        widgetModel: wm,
                                      ): Container()
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: InkWell(
                                  onTap: () => bloc.add(AddDialogState()),
                                  child: const Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      state.dialogState
                          ? GestureDetector(
                              onTap: () => bloc.add(AddDialogState()),
                              child: Container(
                                color: Colors.black38,
                              ),
                            )
                          : Container(),
                      state.dialogState
                          ? Positioned(
                              child: Align(
                                  alignment: Alignment.center,
                                  child: AddWidgetView()),
                            )
                          : Container()
                    ],
                  ),
                ),
                state.expandedId >=0? Align(
                  alignment: Alignment.center,
                  child: ExpandedWidget(
                    widgetModel: state.widgetList.firstWhere((element) => element.id == state.expandedId),
                    bloc: bloc,),
                ) : Container()
              ],
            ),
          );
        },
      );

  Widget get _getDragTarget => BlocBuilder<DragBloc, DragState>(
        builder: (BuildContext context, state) {
          return Positioned(
            right: 30,
            bottom: 30,
            child: AnimatedOpacity(
              opacity: state.didItemOverRemoveTarget ? 0.4 : 1,
              duration: const Duration(milliseconds: 1000),
              child: AnimatedScale(
                scale: state.holdState? 1 : !state.holdState? 0 : state.didItemOverRemoveTarget ? 1.5 : 1,
                duration: const Duration(milliseconds: 500),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child:
                  // state.holdState
                  //     ?
                  DragTarget<int>(
                          onMove: (d) {
                            bloc.add(OnItemOverDeleteTargetStateChange(true));
                          },
                          onLeave: (d) {
                            bloc.add(OnItemOverDeleteTargetStateChange(false));
                          },
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          ) {
                            return ClipOval(
                              child: Container(
                                height: 100.0,
                                width: 100.0,
                                color: Colors.red,
                                child: const Center(
                                    child: Icon(
                                  Icons.delete_outline_outlined,
                                  color: Colors.white,
                                  size: 45,
                                )),
                              ),
                            );
                          },
                          onAcceptWithDetails: (data) {
                            bloc.add(OnRemoveReq(data.data));
                          },
                        )
                      // : Container(),
                ),
              ),
            ),
          );
        },
      );

  Future<WidgetModel?>? _showAddItemDialog(BuildContext context) async {
    return showDialog<WidgetModel>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        String x = "0";
        String y = "0";
        return AlertDialog(
          title: const Text("Add item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('The item will be added to item list'),
              TextFormField(
                onChanged: (v) {
                  x = v;
                },
                decoration: const InputDecoration(labelText: "X coordinates"),
              ),
              TextFormField(
                onChanged: (v) {
                  y = v;
                },
                decoration: const InputDecoration(labelText: "y coordinates"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop({"x": x, "y": y});
              },
            ),
            ElevatedButton(
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
