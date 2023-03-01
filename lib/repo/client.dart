import '../helpers/states/api_values.dart';

abstract class Client<T, E>{
  late String specialKey;

  Client(this.specialKey);

  Future<E?> callPost({required Map<String, dynamic> data, required ApiValues apiValues});

}