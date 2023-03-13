

import '../constaints.dart';

enum WidgetTypes{
  SWITCH, COUNTER, CLIMATE_SENSOR, CLIMATE_CONTROL_PANEL, UNDEFINED;
}

class WidgetType{
 static WidgetTypes fromId(int id){
    switch(id.toString().substring(0, 4)){
      case "2040": return WidgetTypes.CLIMATE_SENSOR;
      case "2041": return WidgetTypes.CLIMATE_SENSOR;
      case "2042": return WidgetTypes.CLIMATE_SENSOR;
      case "2043": return WidgetTypes.COUNTER;
      case "2070": return WidgetTypes.SWITCH;
      default: return WidgetTypes.UNDEFINED;
    }
  }
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


  String get getId{
    switch(this){
      case WidgetTypes.SWITCH:
        return "2070";
      case WidgetTypes.COUNTER:
        return "2043";
      case WidgetTypes.CLIMATE_SENSOR:
        return "2040";
      case WidgetTypes.CLIMATE_CONTROL_PANEL:
        return "2041";
      case WidgetTypes.UNDEFINED:
        return "0000";
    }
  }

}