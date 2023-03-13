class ModuleModel {
  String id;
  String objectName;
  String hubId;
  String name;
  bool status;
  String rssi;
  String vpower;
  String swver;

  ModuleModel(
      {required this.id,
      required this.objectName,
      required this.hubId,
      required this.name,
      required this.status,
      required this.rssi,
      required this.vpower,
      required this.swver});

  factory ModuleModel.fromMap(Map<String, dynamic> map) => ModuleModel(
      id: map["id"],
      objectName: map["object_name"],
      hubId: map["hub_id"],
      name: map["name"],
      status: map["status"] == "true",
      rssi: map["rssi"],
      vpower: map["vpower"],
      swver: map["swver"]);
}
