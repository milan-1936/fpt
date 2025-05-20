part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

class FetchTodoLoading extends TodoState {}

class FetchTodoLoaded extends TodoState {
  final List<Todo> todo;
  FetchTodoLoaded(this.todo);
}

class FetchTodoFail extends TodoState {
  final String errorMessage;
  FetchTodoFail(this.errorMessage);
}

// Add Todo Events
class AddTodoLoadingState extends TodoState {}

class AddTodoSuccessState extends TodoState {
  final String message;
  AddTodoSuccessState({required this.message});
}

class AddTodoFailState extends TodoState {
  final String message;
  AddTodoFailState({required this.message});
}
