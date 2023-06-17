import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/todo.dart';

Future<List> getTodo() async {
  Uri url = Uri.parse('https://yarinim277.pythonanywhere.com/api/v1/tasks/');
  http.Response response = await http.get(url);
  final dataFromJson = jsonDecode(response.body);

  return dataFromJson;
}

Future<int> addTodo(Todo item) async {
  Uri url = Uri.parse('https://yarinim277.pythonanywhere.com/api/v1/tasks/');
  Map<String, Object> body = {
    'title': item.title,
    'description': item.description,
  };
  http.Response response = await http.post(url, body: jsonEncode(body));

  return response.statusCode;
}

Future<int> deleteTodo(int id) async {
  Uri url = Uri.parse('https://yarinim277.pythonanywhere.com/api/v1/tasks/$id');

  http.Response response = await http.delete(url);
  return response.statusCode;
}

Future<int> done(int id) async {
  Uri url = Uri.parse('https://yarinim277.pythonanywhere.com/api/v1/tasks/$id/done');

  http.Response response = await http.post(url);
  return response.statusCode;
}

Future<int> undone(int id) async {
  Uri url = Uri.parse('https://yarinim277.pythonanywhere.com/api/v1/tasks/$id/undone');

  http.Response response = await http.post(url);
  return response.statusCode;
}
