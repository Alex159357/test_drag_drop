import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_drag_drop/helpers/states/widget_types.dart';
import 'package:test_drag_drop/model/counter_model.dart';
import 'package:test_drag_drop/model/module_id.dart';
import 'package:test_drag_drop/model/switch_model.dart';
import '../../model/climate_control_model.dart';
import '../../model/climate_sensor_model.dart';
import '../../model/widget_model.dart';
import '../../repo/main_repo.dart';
import '../../repo/main_repo_impl.dart';
import 'drag_event.dart';
import 'drag_state.dart';
import 'dart:math';

class DragBloc extends Bloc<DragEvent, DragState> {
  final List<WidgetModel> _widgetList = [];
  final MainRepo _mainRepoImpl = MainRepoImpl();

  DragBloc() : super(DragState().init()) {
    on<InitEvent>(_init);
    on<OnWidgetPositionChanged>(_onWidgetPositionChanged);
    on<OnWidgetClickedDragEvent>(_onWidgetClick);
    on<OnAddItemClicked>(_onAddClicked);
    on<InitSize>(_onSizeChanged);
    on<OnHoldStateChanged>(_onHoldStateChanged);
    on<OnRemoveReq>(_removeItem);
    on<OnItemOverDeleteTargetStateChange>(_onOvertargetStateChange);
    on<OnZoomIn>(_onZoomIn);
    on<OnZoomOut>(_onZoomOut);
    on<OnZoomChanged>(_onZoomChanged);
    on<OnSceneUpdated>(_onSceneUpdated);
    on<AddDialogState>(_onDialogStateChanged);
    on<OnWidgetNameChanged>(_onWidgetNameChanged);
    on<OnTypeChanged>(_onWidgetTypeChanged);
    on<OnAddWidgetBtnPressed>(_onAddWidgetBtnPressed);
    on<OnTagNameChanged>(_onTagNameChanged);
    on<OnSwitchStateChanged>(_onSwitchStateChanged);
    on<OnHoverWidget>(_onHover);
    on<OnHubChanged>(_onHubChanged);
    on<OnModuleSelected>(_onModuleSelected);
    on<OnWidgetMoved>(_onWidgetMoved);
  }

  void _init(InitEvent event, Emitter<DragState> emit) async {
    var response = await _mainRepoImpl.fetchWidgets();
    var habs = await _mainRepoImpl.fetchHubs();
    var modules = await _mainRepoImpl.fetchModuleList(1);
    print("Moduled - ${modules}");
    _widgetList.clear();
    _widgetList.addAll(response as List<WidgetModel>);
    emit(state.clone(
        addWidgetState: state.addWidgetState.clone(),
        widgetList: _widgetList,
        hubList: habs,
        modelList: modules));
  }

  FutureOr<void> _onWidgetPositionChanged(
      OnWidgetPositionChanged event, Emitter<DragState> emit) async {
    // _widgetList[_widgetList.indexWhere((element) => element.id == event.id)]
    //     .changeCoordinates(dx: event.dx, dy: event.dy);
    var indexOfMovedWidget =
        _widgetList.indexWhere((element) => element.id == event.id);
    var movedElement = _widgetList[indexOfMovedWidget];
    movedElement.changeCoordinates(dx: event.dx, dy: event.dy);
    _widgetList.removeAt(indexOfMovedWidget);
    _widgetList.insert(indexOfMovedWidget, movedElement);
    emit(state.clone(widgetList: _widgetList));
  }

  FutureOr<void> _onWidgetClick(
      OnWidgetClickedDragEvent event, Emitter<DragState> emit) {
    emit(state.clone(expandedId: event.clickedId));
  }

  FutureOr<void> _onAddClicked(
      OnAddItemClicked event, Emitter<DragState> emit) {
    _widgetList.add(event.widgetModel);
    emit(state.clone(widgetList: _widgetList));
  }

  FutureOr<void> _onSizeChanged(InitSize event, Emitter<DragState> emit) {
    var wDif = (event.width - state.initialWidth) / 2;
    var hDif = (event.height - state.initialHeight) / 2;

    _widgetList.forEach((element) {
      _widgetList.remove(element);
      if (state.initialWidth < event.width) {
        element.changeCoordinates(dx: element.dx! + wDif, dy: element.dy!);
      } else if (state.initialWidth > event.width) {
        if (wDif >= 0) {
          element.changeCoordinates(dx: element.dx! - wDif, dy: element.dy!);
        } else {
          element.changeCoordinates(dx: element.dx! + wDif, dy: element.dy!);
        }
      }

      if (state.initialHeight < event.height) {
        element.changeCoordinates(dx: element.dx!, dy: element.dy! + hDif);
      } else if (state.initialHeight > event.height) {
        if (hDif >= 0) {
          element.changeCoordinates(dx: element.dx!, dy: element.dy! - hDif);
        } else {
          element.changeCoordinates(dx: element.dx!, dy: element.dy! + hDif);
        }
      }
      _widgetList.add(element);
    });
    emit(state.clone(
        initialWidth: event.width,
        initialHeight: event.height,
        widgetList: _widgetList));
  }

  FutureOr<void> _onHoldStateChanged(
      OnHoldStateChanged event, Emitter<DragState> emit) {
    emit(state.clone(holdState: event.state));
  }

  FutureOr<void> _removeItem(OnRemoveReq event, Emitter<DragState> emit) async {
     var response = await _mainRepoImpl.deleteWidget(event.id);
    _widgetList.removeWhere((element) => element.id == event.id);
    emit(state.clone(widgetList: _widgetList, holdState: false));
     _widgetList.clear();
     _widgetList.addAll(response as List<WidgetModel>);
     emit(state.clone(widgetList: _widgetList, holdState: false));
  }

  FutureOr<void> _onOvertargetStateChange(
      OnItemOverDeleteTargetStateChange event, Emitter<DragState> emit) {
    emit(state.clone(didItemOverRemoveTarget: event.state));
  }

  FutureOr<void> _onZoomIn(OnZoomIn event, Emitter<DragState> emit) {
    emit(state.clone(
        zoom: state.zoom < 5 ? state.zoom + .2 : state.zoom,
        didUpdateScene: true));
  }

  FutureOr<void> _onZoomOut(OnZoomOut event, Emitter<DragState> emit) {
    emit(state.clone(
        zoom: state.zoom > .4 ? state.zoom - .2 : state.zoom,
        didUpdateScene: true));
  }

  FutureOr<void> _onZoomChanged(OnZoomChanged event, Emitter<DragState> emit) {
    emit(state.clone(zoom: event.zoom, didUpdateScene: true));
  }

  FutureOr<void> _onSceneUpdated(
      OnSceneUpdated event, Emitter<DragState> emit) {
    // emit(state.clone(didUpdateScene: false, zoom: event.zoom));
  }

  FutureOr<void> _onDialogStateChanged(
      AddDialogState event, Emitter<DragState> emit) {
    emit(state.clone(dialogState: !state.dialogState));
  }

  FutureOr<void> _onWidgetNameChanged(
      OnWidgetNameChanged event, Emitter<DragState> emit) {
    emit(state.clone(
        addWidgetState: state.addWidgetState.clone(name: event.name)));
  }

  FutureOr<void> _onAddWidgetBtnPressed(
      OnAddWidgetBtnPressed event, Emitter<DragState> emit) async {
    // WidgetTypes widgetTypes = WidgetTypes.values.firstWhere(
    //     (element) => element.getTitle == state.addWidgetState.widgetType);
    int widgetId = -1;
    var rng = Random();
    for (var i = 0; i < 10; i++) {
      print(rng.nextInt(9999));
    }
    Future.doWhile(() {
      widgetId = rng.nextInt(9999);
      print("GeneratedId -> $widgetId");
      return false;
    });

    // do{
    //
    // }while(_widgetList.firstWhereOrNull((element) => element.id == widgetId) == null);

    WidgetModel wmTmp = WidgetModel(
        id: widgetId,
        name: state.addWidgetState.name,
        moduleId: state.addWidgetState.selectedModule,
        moduleHubId: state.addWidgetState.selectedHub,
        dx: 0,
        dy: 0);

    // switch (widgetTypes) {
    //   case WidgetTypes.SWITCH:
    //     wmTmp = SwitchModel(
    //         id: _widgetList.length + 1,
    //         name: state.addWidgetState.name,
    //         dx: 100,
    //         dy: 100,
    //         moduleId: state.addWidgetState.selectedModule,
    //         moduleName: "");
    //     break;
    //   case WidgetTypes.COUNTER:
    //     wmTmp = CounterModel(
    //         id: _widgetList.length + 1,
    //         name: state.addWidgetState.name,
    //         dx: 100,
    //         dy: 100,
    //         moduleId: state.addWidgetState.selectedModule,
    //         moduleName: "");
    //     break;
    //   case WidgetTypes.CLIMATE_SENSOR:
    //     wmTmp = ClimateSensorModel(
    //         id: _widgetList.length + 1,
    //         name: state.addWidgetState.name,
    //         dx: 100,
    //         dy: 100,
    //         moduleId: state.addWidgetState.selectedModule,
    //         moduleName: "");
    //     break;
    //   case WidgetTypes.CLIMATE_CONTROL_PANEL:
    //     wmTmp = ClimateControlModel(
    //         id: _widgetList.length + 1,
    //         name: state.addWidgetState.name,
    //         dx: 100,
    //         dy: 100,
    //         moduleId: state.addWidgetState.selectedModule,
    //         moduleName: "");
    //     break;
    //   case WidgetTypes.UNDEFINED:
    //     break;
    // }
    final response = await _mainRepoImpl.addDevice(wmTmp);
    if (response != null) {
      _widgetList.clear();
      _widgetList.addAll(response!);
      emit(state.clone(
          widgetList: _widgetList,
          addWidgetState: state.addWidgetState.clone(),
          dialogState: !state.dialogState));
    } else {
      Fluttertoast.showToast(
          msg: "Error while adding widget", backgroundColor: Colors.redAccent);
    }
  }

  FutureOr<void> _onWidgetTypeChanged(
      OnTypeChanged event, Emitter<DragState> emit) {
    emit(state.clone(
        addWidgetState: state.addWidgetState.clone(widgetType: event.type)));
  }

  FutureOr<void> _onTagNameChanged(
      OnTagNameChanged event, Emitter<DragState> emit) {
    emit(state.clone(
        addWidgetState: state.addWidgetState.clone(widgetTag: event.tag)));
  }

  FutureOr<void> _onSwitchStateChanged(
      OnSwitchStateChanged event, Emitter<DragState> emit) {
    ModuleModel? sm;
    state.modelList.forEach((element) {
      if (element.id == event.id) {
        sm!.status = event.state;
      }
    });
    if (sm != null) {
      _mainRepoImpl.passAction(
          hubid: sm!.hubId!, id: sm!.id, state: event.state);
    }
    emit(state.clone(widgetList: _widgetList));
  }

  FutureOr<void> _onHover(OnHoverWidget event, Emitter<DragState> emit) {
    emit(state.clone(hoverId: event.hoveredId));
  }

  FutureOr<void> _onHubChanged(OnHubChanged event, Emitter<DragState> emit) {
    emit(state.clone(
        addWidgetState: state.addWidgetState.clone(selectedHub: event.id)));
  }

  FutureOr<void> _onModuleSelected(
      OnModuleSelected event, Emitter<DragState> emit) {
    emit(state.clone(
        addWidgetState:
            state.addWidgetState.clone(selectedModule: event.moduleId)));
  }

  FutureOr<void> _onWidgetMoved(OnWidgetMoved event, Emitter<DragState> emit) {
    WidgetModel? wmTmp = _widgetList
        .firstWhereOrNull((element) => element.id.toString() == event.id);
    _mainRepoImpl.widgetMoved(wmTmp!);
  }
}
