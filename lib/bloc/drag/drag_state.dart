import '../../model/widget_model.dart';

class DragState {
  final List<WidgetModel> widgetList;
  final int expandedId;
  final double initialWidth;
  final double initialHeight;
  final double wDef;
  final double hDef;
  final bool holdState;
  final bool didItemOverRemoveTarget;

  DragState(
      {this.widgetList = const [],
      this.expandedId = -1,
      this.initialWidth = 0.0,
      this.initialHeight = 0.0,
      this.wDef = 0.0,
      this.hDef = 0.0, this.holdState = false, this.didItemOverRemoveTarget = false});

  DragState init() {
    return DragState();
  }

  DragState clone(
      {List<WidgetModel>? widgetList,
      int? expandedId,
      double? initialWidth,
      double? initialHeight,
      final double? wDef,
      double? hDef, bool? holdState, bool? didItemOverRemoveTarget}) {
    return DragState(
        widgetList: widgetList ?? this.widgetList,
        expandedId: expandedId ?? this.expandedId,
        initialWidth: initialWidth ?? this.initialWidth,
        initialHeight: initialHeight ?? this.initialHeight,
        wDef: wDef ?? this.wDef,
        hDef: hDef ?? this.hDef,
        holdState: holdState ?? this.holdState,
        didItemOverRemoveTarget: didItemOverRemoveTarget ?? this.didItemOverRemoveTarget
    );
  }
}
