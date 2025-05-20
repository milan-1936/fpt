import '../../../../Core/api/api_error/api_calls.dart';
import '../model/todo.dart';

abstract class TodoDataSource {
  Future<List<Todo>> fetchTodo();
  Future<String> storeTodo({required Map<String, dynamic> formData});
}

class TodoDataSourceImpl extends TodoDataSource {
  final ApiCalls apicalls;
  TodoDataSourceImpl(this.apicalls);
  @override
  Future<List<Todo>> fetchTodo() async {
    final result = await apicalls.getData(endpoint: "todo") as List;
    return result.map((todo) => Todo.fromMap(todo)).toList();
  }

  @override
  Future<String> storeTodo({required Map<String, dynamic> formData}) async {
    final response = await apicalls.sendData(
      endpoint: "todo",
      formData: formData,
    );
    return response['message'];
  }
}

// add a class here
