

enum ApiValues{
  DEVICE_LIST, DEVICE_ACTION, HUB_LIST, ADD_DEVICE, MODULES, ON_WIDGEET_POSITION_CHANGED, DELETE_WIDGET
}

extension Api on ApiValues{

  String get getUrl {
    switch (this) {
      case ApiValues.DEVICE_LIST:
        return "show_panel";
      case ApiValues.DEVICE_ACTION:
        return "sendcommand";
      case ApiValues.HUB_LIST:
        return "show_hubs";
      case ApiValues.ADD_DEVICE:
        return "add_widget";
      case ApiValues.MODULES:
       return "show_modules_by_object";
      case ApiValues.ON_WIDGEET_POSITION_CHANGED:
       return "change_widget_coordinates";
       case ApiValues.DELETE_WIDGET:
       return "delete_widget";
    }
  }

}