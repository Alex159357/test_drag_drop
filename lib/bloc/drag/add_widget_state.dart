import 'package:test_drag_drop/helpers/states/widget_types.dart';

import '../../helpers/constaints.dart';

class AddWidgetState {
  final String name;
  final String widgetType;
  final String widgetTag;

  bool get didFieldsValid => name.isNotEmpty && widgetTag.isNotEmpty && widgetType.isNotEmpty;

  const AddWidgetState(
      {this.name = "", this.widgetType = "", this.widgetTag = ""});

  AddWidgetState clone({String? name, String? widgetType, String? widgetTag}) =>
      AddWidgetState(
        name: name ?? this.name,
        widgetType: widgetType ?? this.widgetType,
        widgetTag: widgetTag ?? this.widgetTag
      );
}
