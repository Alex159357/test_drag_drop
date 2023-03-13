import '../../model/widget_model.dart';

abstract class DragEvent {}

class InitEvent extends DragEvent {}

class OnWidgetPositionChanged extends DragEvent{
  final double dx;
  final double dy;
  final int id;

  OnWidgetPositionChanged({required this.dx, required this.dy, required this.id});
}

class OnWidgetClickedDragEvent extends DragEvent{
  final int clickedId;

  OnWidgetClickedDragEvent({this.clickedId = -1});
}

class OnAddItemClicked extends DragEvent{
  final WidgetModel widgetModel;

  OnAddItemClicked(this.widgetModel);
}

class InitSize extends DragEvent{
  final double width;
  final double height;

  InitSize({required this.width, required this.height});
}

class OnHoldStateChanged extends DragEvent{
  final bool state;

  OnHoldStateChanged(this.state);
}

class OnRemoveReq extends DragEvent{
  final int id;

  OnRemoveReq(this.id);
}

class OnItemOverDeleteTargetStateChange extends DragEvent{
  final bool state;

  OnItemOverDeleteTargetStateChange(this.state);
}
class OnZoomIn extends DragEvent{}

class OnZoomOut extends DragEvent{}

class OnZoomChanged extends DragEvent{
  final double zoom;

  OnZoomChanged(this.zoom);
}

class OnSceneUpdated extends DragEvent{
  final double zoom;

  OnSceneUpdated(this.zoom);
}

class AddDialogState extends DragEvent{}

class OnWidgetNameChanged extends DragEvent{
  final String name;

  OnWidgetNameChanged(this.name);
}

class OnTypeChanged extends DragEvent{
  final String type;

  OnTypeChanged(this.type);
}

class OnAddWidgetBtnPressed extends DragEvent{}

class OnTagNameChanged extends DragEvent{
  final String tag;

  OnTagNameChanged(this.tag);
}

class OnSwitchStateChanged extends DragEvent{
  final int id;
  final bool state;

  OnSwitchStateChanged({required this.id, required this.state});
}

class OnHoverWidget extends DragEvent{
  final int hoveredId;

  OnHoverWidget(this.hoveredId);
}

class OnHubChanged extends DragEvent{
  final String id;

  OnHubChanged(this.id);
}

class OnModuleSelected extends DragEvent{
  final String moduleId;

  OnModuleSelected(this.moduleId);
}

class OnWidgetMoved extends DragEvent{
  final double dx;
  final double dy;
  final String id;

  OnWidgetMoved({required this.dx, required this.dy, required this.id});
}