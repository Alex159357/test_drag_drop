

enum ApiValues{
  DEVICE_LIST
}

extension Api on ApiValues{

  String get getUrl {
    switch (this) {
      case ApiValues.DEVICE_LIST:
        return "show_modules_by_object";
    }
  }

}