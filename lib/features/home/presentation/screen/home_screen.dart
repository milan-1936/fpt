import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serious_todo/Constants/app_routes.dart';
import 'package:serious_todo/features/home/presentation/blocs/todo_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoBloc = context.read<TodoBloc>().add(FetchTodoEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do Application"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.formRoutes);
              },
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is FetchTodoFail) {
            return Center(child: Text(state.errorMessage));
          }
          if (state is FetchTodoLoaded) {
            return ListView.builder(
              itemCount: state.todo.length,
              itemBuilder: (ctx, index) {
                return Card(
                  child: ListTile(
                    leading: Checkbox(
                      value: state.todo[index].isCompleted,
                      onChanged: (e) {},
                    ),
                    title: Text(state.todo[index].title),
                    subtitle: Text(state.todo[index].description),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete_outline),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
