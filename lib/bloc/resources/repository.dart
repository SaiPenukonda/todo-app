import 'dart:async';
import 'package:todoapp/models/classes/task.dart';
import 'package:todoapp/models/classes/user.dart';
import 'api.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<User> registerUser(String username, String firstname, String lastname, String password, String email)
   => apiProvider.registerUser(username, firstname, lastname, password, email);

  Future signinUser(String username, String password, String apiKey)
   => apiProvider.signinUser(username, password, apiKey);

  Future<List<Task>> getUserTasks(String apiKey)
   => apiProvider.getUserTasks(apiKey);
}