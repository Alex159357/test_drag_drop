


import '../model/switch_model.dart';


class MainMapper<T>{

  T? mapToModel(Map<String, dynamic> map){
    if(T == SwitchModel){
      print("StartMapping -> ");
      return SwitchModel.fromMap(map) as T;
    }
    return null;
  }

}