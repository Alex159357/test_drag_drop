

import '../constaints.dart';

enum WidgetTypes{
  SWITCH, COUNTER, CLIMATE_SENSOR, CLIMATE_CONTROL_PANEL, UNDEFINED
}

extension Ex on WidgetTypes {


  String get getTitle {
    switch (this) {
      case WidgetTypes.UNDEFINED:
        return WidgetTypeConstraints.undefinedTitle;
      case WidgetTypes.SWITCH:
        return WidgetTypeConstraints.switchTitle;
      case WidgetTypes.COUNTER:
        return WidgetTypeConstraints.counterTitle;
      case WidgetTypes.CLIMATE_SENSOR:
        return WidgetTypeConstraints.climateSensorTitle;
      case WidgetTypes.CLIMATE_CONTROL_PANEL:
        return WidgetTypeConstraints.climateSensorControlTitle;
    }
  }

  WidgetTypes fromTitle(String title) {
    switch(title){
      case  WidgetTypeConstraints.undefinedTitle: return WidgetTypes.SWITCH;
      case WidgetTypeConstraints.counterTitle: return WidgetTypes.COUNTER;
      case WidgetTypeConstraints.climateSensorTitle: return WidgetTypes.CLIMATE_SENSOR;
      case WidgetTypeConstraints.climateSensorControlTitle: return WidgetTypes.CLIMATE_CONTROL_PANEL;
      default: return WidgetTypes.UNDEFINED;
    }
  }

}