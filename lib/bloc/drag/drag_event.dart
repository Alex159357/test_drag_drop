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

  OnWidgetClickedDragEvent(this.clickedId);
}

class OnAddItemClicked extends DragEvent{
  final double dx;
  final double dy;

  OnAddItemClicked({required this.dx, required this.dy});
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