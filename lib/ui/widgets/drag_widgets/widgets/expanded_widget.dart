import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_drag_drop/bloc/drag/drag_bloc.dart';
import 'package:test_drag_drop/model/widget_model.dart';

import '../../../../bloc/drag/drag_event.dart';
import '../../../../bloc/drag/drag_state.dart';
import '../../../../model/switch_model.dart';

class ExpandedWidget extends StatelessWidget {
  final WidgetModel widgetModel;
  final DragBloc bloc;

  ExpandedWidget({Key? key, required this.widgetModel, required this.bloc}) : super(key: key);

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
                            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
                        Text(widgetModel.name),
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
    switch(widgetModel.runtimeType){
      case SwitchModel: return _getSwitchView;
      default: return Container();
    }
  }

  Widget get _getSwitchView => BlocBuilder<DragBloc, DragState>(builder: (BuildContext context, state) {
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
                value: widgetModel.status ?? false,
                onChanged: (bool value) {
                  bloc.add(OnSwitchStateChanged(
                      id: widgetModel.id, state: value));
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
              child: IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(onPressed: (){}, icon: Icon(Icons.close)),
            ),
          ],
        ),
      ],
    );
  },);

}
