class HubIdModel {
  String? id;
  String? status;
  String? objectId;
  String? objectName;

  HubIdModel(
      {required this.id, required this.status, required this.objectId, required this.objectName});


  factory HubIdModel.fromMap(Map<String, dynamic> map) => HubIdModel(
    id: map["id"],
    status: map["status"],
    objectId: map["object_id"],
    objectName: map["object_name"]);

}