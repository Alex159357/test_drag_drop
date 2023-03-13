import 'package:test_drag_drop/helpers/states/widget_types.dart';

import '../../helpers/constaints.dart';

class AddWidgetState {
  final String name;
  final String widgetType;
  final String widgetTag;
  final String selectedModule;
  final String selectedHub;

  bool get didFieldsValid =>
      name.isNotEmpty && widgetTag.isNotEmpty && selectedHub.isNotEmpty && selectedHub.isNotEmpty;

  const AddWidgetState(
      {this.name = "",
      this.widgetType = "",
      this.widgetTag = "",
      this.selectedModule = "",
      this.selectedHub = ""});

  AddWidgetState clone(
          {String? name,
          String? widgetType,
          String? widgetTag,
          String? selectedModule, String? selectedHub}) =>
      AddWidgetState(
        name: name ?? this.name,
        widgetType: widgetType ?? this.widgetType,
        widgetTag: widgetTag ?? this.widgetTag,
        selectedModule: selectedModule ?? this.selectedModule,
          selectedHub: selectedHub ?? this.selectedHub
      );
}
