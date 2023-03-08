

enum ApiValues{
  DEVICE_LIST, DEVICE_ACTION, HUB_LIST
}

extension Api on ApiValues{

  String get getUrl {
    switch (this) {
      case ApiValues.DEVICE_LIST:
        return "show_modules_by_object";
      case ApiValues.DEVICE_ACTION:
        return "sendcommand";
      case ApiValues.HUB_LIST:
        return "show_hubs";
    }
  }

}