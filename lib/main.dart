import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:local_storage_hive/models/todo.dart';
import 'package:local_storage_hive/views/todo_view.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('todos'); // samain kayak controller
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: TodoView(),
    );
  }
}
