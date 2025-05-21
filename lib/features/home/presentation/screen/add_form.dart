import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serious_todo/features/home/presentation/blocs/todo_bloc.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  String? title;
  String? description;
  final GlobalKey<FormState> addTodoForm = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TodoForm")),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is AddTodoSuccessState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is AddTodoFailState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Form(
              key: addTodoForm,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(hintText: "Title"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Provide Title";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      title = value;
                    },
                    onTapOutside: (e) => FocusScope.of(context).unfocus(),
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Description"),
                    maxLines: 6,
                    minLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Provide Description";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      description = value;
                    },
                    onTapOutside: (e) => FocusScope.of(context).unfocus(),
                  ),
                  Row(
                    children: [
                      BlocBuilder<TodoBloc, TodoState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              if (!addTodoForm.currentState!.validate()) {
                                return;
                              }
                              addTodoForm.currentState!.save();
                              final Map<String, dynamic> formData = {
                                'title': title,
                                'description': description,
                              };
                              context.read<TodoBloc>().add(
                                AddTodoEvent(formData: formData),
                              );
                              context.read<TodoBloc>().add(FetchTodoEvent());
                              Navigator.of(context).pop();
                            },
                            child: Text("Save"),
                          );
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
