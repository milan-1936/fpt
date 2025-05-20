import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:serious_todo/features/home/data/model/todo.dart';
import 'package:serious_todo/features/home/data/repositories/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  TodoBloc(this.todoRepository) : super(TodoInitial()) {
    on<TodoEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchTodoEvent>((event, emit) async {
      emit(FetchTodoLoading());
      final result = await todoRepository.fetchTodo();
      result.fold(
        (error) => emit(FetchTodoFail(error.errorMessage)),
        (success) => emit(FetchTodoLoaded(success)),
      );
    });

    on<AddTodoEvent>((event, emit) async {
      emit(AddTodoLoadingState());
      final response = await todoRepository.storeTodo(formData: event.formData);
      response.fold(
        (error) => emit(AddTodoFailState(message: error.errorMessage)),
        (success) => emit(AddTodoSuccessState(message: success)),
      );
    });
  }
}
