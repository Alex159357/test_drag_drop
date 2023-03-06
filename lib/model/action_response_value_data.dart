class ActionResponseValueData {
  int id;
  int value;
  String paramOut;
  int process;

  ActionResponseValueData(
      {required this.id,
      required this.value,
      required this.paramOut,
      required this.process});

  factory ActionResponseValueData.fromMap(Map<String, dynamic> map) =>
      ActionResponseValueData(
          id: int.parse(map["idOut"].toString()),
          value: int.parse(map["value"].toString()),
          paramOut: map["paramOut"],
          process: int.parse(map["process"]));
}
