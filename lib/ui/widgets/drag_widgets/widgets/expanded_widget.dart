import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_drag_drop/bloc/drag/drag_bloc.dart';
import 'package:test_drag_drop/model/climate_sensor_model.dart';
import 'package:test_drag_drop/model/counter_model.dart';
import 'package:test_drag_drop/model/widget_model.dart';

import '../../../../bloc/drag/drag_event.dart';
import '../../../../bloc/drag/drag_state.dart';
import '../../../../model/module_id.dart';
import '../../../../model/switch_model.dart';

class ExpandedWidget extends StatelessWidget {
  final WidgetModel widgetModel;
  final DragBloc bloc;

  ExpandedWidget({Key? key, required this.widgetModel, required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: ()=>  bloc.add(OnWidgetClickedDragEvent()),
      child: Container(
        color: Colors.black38,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              color: Colors.white,
              shadowColor: Colors.black38,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () =>
                                bloc.add(OnWidgetClickedDragEvent()),
                            icon:
                                const Icon(Icons.arrow_back_ios_new_outlined)),
                        Text(widgetModel.name!),
                      ],
                    ),
                    _getBody
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _getBody {
    switch (widgetModel.runtimeType) {
      case SwitchModel:
        return _getSwitchView;
      case ClimateSensorModel:
        return _getClimateSensorView;
        case CounterModel:
        return _getCounterView;
      default:
        return Container();
    }
  }

  Widget get _getCounterView => BlocBuilder<DragBloc, DragState>(
  builder: (BuildContext context, state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              padding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: const [Text("Counter1:"), Text("0")],
              ),
            ),
            Container(
              margin:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              padding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: const [Text("Counter2:"), Text("0")],
              ),
            )
          ],
        ),
      ],
    );
  });

  Widget get _getClimateSensorView => BlocBuilder<DragBloc, DragState>(
        builder: (BuildContext context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: const [Text("Temperature:"), Text("0  \u2103")],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: const [Text("Humidity:"), Text("0 %")],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: const [Text("Humidity:"), Text("0 %")],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Actions"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                  ),
                ],
              ),
            ],
          );
        },
      );

  Widget get _getSwitchView => BlocBuilder<DragBloc, DragState>(
        builder: (BuildContext context, state) {
          ModuleModel curModel = state.modelList.firstWhere((element) => element.id == widgetModel.moduleId);
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("State"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CupertinoSwitch(
                      trackColor: Colors.black12,
                      value: curModel.status == "true" ?? false,
                      onChanged: (bool value) {
                        bloc.add(OnSwitchStateChanged(
                            id: int.parse(curModel.id), state: value));
                        // context.read<DragBloc>().add(OnSwitchStateChanged(
                        //     id: widgetModel.id, state: value));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Actions"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                  ),
                ],
              ),
            ],
          );
        },
      );
}
