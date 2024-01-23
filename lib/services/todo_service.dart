import 'dart:convert';
import 'package:http/http.dart' as http;

class TodoService {
  Future<http.Response> todoService() async {
    const url = 'https://jsonplaceholder.typicode.com/todos';
    Uri uri = Uri.parse(url);
    return await http.get(uri);
  }
}
