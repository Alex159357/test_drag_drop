

enum ApiValues{
  DEVICE_LIST, DEVICE_ACTION
}

extension Api on ApiValues{

  String get getUrl {
    switch (this) {
      case ApiValues.DEVICE_LIST:
        return "show_modules_by_object";
      case ApiValues.DEVICE_ACTION:
        return "sendcommand";
    }
  }

}