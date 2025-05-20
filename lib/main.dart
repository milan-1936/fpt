import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serious_todo/Core/services/service_locator.dart';
import 'package:serious_todo/features/home/data/repositories/todo_repository.dart';
import 'package:serious_todo/features/home/presentation/blocs/todo_bloc.dart';
import 'package:serious_todo/features/home/presentation/screen/add_form.dart';
import 'package:serious_todo/features/home/presentation/screen/home_screen.dart';

import 'Constants/app_routes.dart';

void main() {
  serviceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => TodoBloc(getIt<TodoRepository>())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        routes: {
          AppRoutes.homeScreen: (ctx) => HomeScreen(),
          AppRoutes.formRoutes: (ctx) => MyForm(),
        },
      ),
    );
  }
}
