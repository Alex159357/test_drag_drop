import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import '../../model/widget_model.dart';
import 'drag_event.dart';
import 'drag_state.dart';

class DragBloc extends Bloc<DragEvent, DragState> {
  final List<WidgetModel> _widgetList = [];

  DragBloc() : super(DragState().init()) {
    on<InitEvent>(_init);
    on<OnWidgetPositionChanged>(_onWidgetPositionChanged);
    on<OnWidgetClickedDragEvent>(_onWidgetClick);
    on<OnAddItemClicked>(_onAddClicked);
    on<InitSize>(_onSizeChanged);
    on<OnHoldStateChanged>(_onHoldStateChanged);
    on<OnRemoveReq>(_removeItem);
    on<OnItemOverDeleteTargetStateChange>(_onOvertargetStateChange);
  }

  void _init(InitEvent event, Emitter<DragState> emit) async {
    emit(state.clone(widgetList: _widgetList));
  }

  FutureOr<void> _onWidgetPositionChanged(
      OnWidgetPositionChanged event, Emitter<DragState> emit) async {
    _widgetList[_widgetList.indexWhere((element) => element.id == event.id)].changeCoordinates(dx: event.dx, dy: event.dy - 50);
    emit(state.clone(widgetList: _widgetList));
  }

  FutureOr<void> _onWidgetClick(
      OnWidgetClickedDragEvent event, Emitter<DragState> emit) {
    emit(state.clone(expandedId: event.clickedId));
  }

  FutureOr<void> _onAddClicked(
      OnAddItemClicked event, Emitter<DragState> emit) {
    _widgetList.add(WidgetModel(
        id: _widgetList.length + 1, type: 0, dx: event.dx, dy: event.dy));
    emit(state.clone(widgetList: _widgetList));
  }

  FutureOr<void> _onSizeChanged(InitSize event, Emitter<DragState> emit) {
    var wDif = (event.width - state.initialWidth) / 2;
    var hDif = (event.height - state.initialHeight) / 2;

    _widgetList.forEach((element) {
      _widgetList.remove(element);
      if(state.initialWidth < event.width) {
        element.changeCoordinates(dx: element.dx+wDif, dy: element.dy);
      }else if(state.initialWidth > event.width){
        if(wDif >= 0) {
          element.changeCoordinates(dx: element.dx-wDif, dy: element.dy);
        }else {
          element.changeCoordinates(dx: element.dx+wDif, dy: element.dy);
        }
      }

      if(state.initialHeight < event.height){
        element.changeCoordinates(dx: element.dx, dy: element.dy+hDif);
      }else if(state.initialHeight > event.height){
        if(hDif >= 0) {
          element.changeCoordinates(dx: element.dx, dy: element.dy-hDif);
        }else {
          element.changeCoordinates(dx: element.dx, dy: element.dy+hDif);
        }
      }
      _widgetList.add(element);
    });
    emit(state.clone(
        initialWidth: event.width,
        initialHeight: event.height,
        widgetList: _widgetList
    )
    );
  }

  FutureOr<void> _onHoldStateChanged(OnHoldStateChanged event, Emitter<DragState> emit) {
    emit(state.clone(holdState: event.state));
  }

  FutureOr<void> _removeItem(OnRemoveReq event, Emitter<DragState> emit) {
    _widgetList.removeWhere((element) => element.id == event.id);
    emit(state.clone(widgetList: _widgetList, holdState: false));
  }

  FutureOr<void> _onOvertargetStateChange(OnItemOverDeleteTargetStateChange event, Emitter<DragState> emit) {
    emit(state.clone(didItemOverRemoveTarget: event.state));
  }
}
