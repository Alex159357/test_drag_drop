import '../../model/hub_id_model.dart';
import '../../model/module_id.dart';
import '../../model/widget_model.dart';
import 'add_widget_state.dart';

class DragState {
  final List<WidgetModel> widgetList;
  final List<HubIdModel> hubList;
  final List<ModuleModel> modelList;
  final int expandedId;
  final double initialWidth;
  final double initialHeight;
  final double zoom;
  final double wDef;
  final double hDef;
  final bool holdState;
  final bool didUpdateScene;
  final bool didItemOverRemoveTarget;
  final bool dialogState;
  final AddWidgetState addWidgetState;
  final int hoverId;
  final String test;

  DragState(
      {this.widgetList = const [],
      this.expandedId = -1,
      this.initialWidth = 0.0,
      this.initialHeight = 0.0,
      this.wDef = 0.0,
      this.hDef = 0.0,
      this.holdState = false,
      this.didItemOverRemoveTarget = false,
      this.didUpdateScene = true,
      this.zoom = 1,
      this.dialogState = false,
      this.addWidgetState = const AddWidgetState(),
      this.hoverId = -1,
      this.test = "",
      this.hubList = const [],
      this.modelList = const [],
      });

  DragState init() {
    return DragState();
  }

  DragState clone(
      {List<WidgetModel>? widgetList,
      int? expandedId,
      double? initialWidth,
      double? initialHeight,
      final double? wDef,
      double? hDef,
      bool? holdState,
      bool? didItemOverRemoveTarget,
      double? zoom,
      bool? didUpdateScene,
      bool? dialogState,
      AddWidgetState? addWidgetState,
      int? hoverId,
      String? test,
      List<HubIdModel>? hubList,
      List<ModuleModel>? modelList,
      }) {
    return DragState(
        widgetList: widgetList ?? this.widgetList,
        expandedId: expandedId ?? this.expandedId,
        initialWidth: initialWidth ?? this.initialWidth,
        initialHeight: initialHeight ?? this.initialHeight,
        wDef: wDef ?? this.wDef,
        hDef: hDef ?? this.hDef,
        holdState: holdState ?? this.holdState,
        didItemOverRemoveTarget:
            didItemOverRemoveTarget ?? this.didItemOverRemoveTarget,
        zoom: zoom ?? this.zoom,
        didUpdateScene: didUpdateScene ?? this.didUpdateScene,
        dialogState: dialogState ?? this.dialogState,
        addWidgetState: addWidgetState ?? this.addWidgetState,
        hoverId: hoverId ?? this.hoverId,
        test: test ?? this.test,
        hubList: hubList ?? this.hubList,
        modelList: modelList ?? this.modelList,
        );
  }
}
