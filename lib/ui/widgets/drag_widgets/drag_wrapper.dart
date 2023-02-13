
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_drag_drop/model/widget_model.dart';
import 'package:test_drag_drop/ui/widgets/drag_widgets/widgets/widgetType1.dart';
import 'package:test_drag_drop/ui/widgets/drag_widgets/widgets/widget_type_2.dart';

class DragWrapper extends StatelessWidget {
  WidgetModel widgetModel;

  DragWrapper({Key? key, required this.widgetModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      curve: Curves.easeInToLinear,
      duration: Duration(milliseconds: 500),
        left: widgetModel.dx,
        top: widgetModel.dy,
        child: _getChild(widgetModel.type, widgetModel.dx, widgetModel.dy));
  }

  Widget _getChild(int type, double dx, double dy){
    switch(type){
      case 0: return WidgetType1(wm: widgetModel, );
      case 1: return WidgetType2();
      case 2: return WidgetType1(wm: widgetModel,);
      case 3: return WidgetType2();
      case 4: return WidgetType1(wm: widgetModel,);
      default: return Container();
    }
  }

}
