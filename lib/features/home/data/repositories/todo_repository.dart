import 'package:dartz/dartz.dart';
import 'package:serious_todo/Core/api/api_error/api_error.dart';
import 'package:serious_todo/features/home/data/sources/todo_data_source.dart';

import '../model/todo.dart';

abstract class TodoRepository {
  Future<Either<ApiError, List<Todo>>> fetchTodo();
  Future<Either<ApiError, String>> storeTodo({
    required Map<String, dynamic> formData,
  });
}

class TodoRepositoryImpl extends TodoRepository {
  final TodoDataSource todoDataSource;

  TodoRepositoryImpl(this.todoDataSource);

  @override
  Future<Either<ApiError, List<Todo>>> fetchTodo() async {
    try {
      final result = await todoDataSource.fetchTodo();
      return right(result);
    } catch (e) {
      return left(ApiError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<ApiError, String>> storeTodo({
    required Map<String, dynamic> formData,
  }) async {
    try {
      final result = await todoDataSource.storeTodo(formData: formData);
      return right(result);
    } catch (e) {
      return left(ApiError(errorMessage: e.toString()));
    }
  }
}
